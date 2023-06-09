// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:risk/risk_points/risk_points.dart';
import 'package:uuid/uuid.dart';
import 'package:risk/risk_points/risk_points.dart';
import 'package:risk/screens/map/bottomSheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:risk/screens/map/animationFloatingActionButton.dart';
import 'package:risk/screens/map/appBar.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:risk/screens/settings/settings.dart';
import 'package:risk/risk_points/risk_points.dart';

import '../../risk_points/risk_points.dart';

List<Circle> _circles = [];
String error_message = 'Risk Noktası!';
List<RiskPoint>? risk_points;

bool completed = false;

Color circleColor(traffic_accident){
  if(traffic_accident <= 3){
    return Colors.blue.withOpacity(0.5);
  }
  else if(traffic_accident <= 6){
    return Colors.orange.withOpacity(0.5);
  }
  else{
    return Colors.red.withOpacity(0.5);
  }
}

Polygon ankara = const Polygon(
  polygonId: PolygonId('Ankara'),
  points: [
    LatLng(39.756,32.566),
    LatLng(39.870, 32.566),
    LatLng(40.153, 32.511),
    LatLng(40.162, 32.676),
    LatLng( 40.026, 32.842),
    LatLng( 39.809, 32.880),
    LatLng( 39.687, 32.811),
    LatLng( 39.697, 32.639),
    LatLng( 39.756, 32.566),
 ],
  strokeWidth: 2,
  strokeColor: Colors.red,
  fillColor: Colors.transparent,
);


class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({Key? key}) : super(key: key);

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late FlutterTts flutterTts;
  StreamSubscription<Position>? _positionStream;
  bool _showingWarning = false;

  Widget _buildWarning(error_message) {
    if (_showingWarning) {
      _speak(error_message);
      _showingWarning = false;
      return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          child: Text(
            error_message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
  Future<List<Circle>> getData() async{
    List<RiskPoint> a = [];
    String jsonString = await rootBundle.loadString('assets/json/risk_points.json');
    jsonString = jsonString.replaceAll("&#199;", "Ç");
    List<dynamic> data = jsonDecode(jsonString);
    for (var value in data){
      RiskPoint risk_point = RiskPoint.fromJson(value);
      var uuid = Uuid();
      var uniqueId = uuid.v4();
      final circle = Circle(circleId: CircleId(uniqueId), center: LatLng(risk_point.xKoordinat,risk_point.yKoordinat), fillColor: circleColor(risk_point.kazaSayisi), radius: risk_point.kazaSayisi*20,
          onTap: (){
            List<KazaSekli> kaza = risk_point.kazaSekli.toList();
            riskPointBottomSheet(context, kaza);
          },

          strokeWidth: 0,
        consumeTapEvents: true
      );
      _circles.add(circle);
      a.add(risk_point);
    }
    risk_points = a;
    return _circles;
  }


  static late CameraPosition _cameraPosition = CameraPosition(
  bearing: 192.8334901395799,
  target: LatLng(39.93670009643588, 32.85681947778169),
  tilt: 59.440717697143555,
  zoom: 19.151926040649414,
  );

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        completed = true;
      });
    });
    flutterTts = FlutterTts();
    _getCurrentLocation();
    _positionStream = Geolocator.getPositionStream().listen((position) {
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
      });
    });
  }



  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle: GoogleFonts.rajdhani(color: Colors.black),
            icon: Icon(Icons.error_outline, color: Colors.black,),
            title: Text('Lütfen Konum Hizmetlerine İzin Verin!', style: GoogleFonts.rajdhani(),),
          );
        },
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Kullanıcı konum erişimini vermedi, hata mesajı göster
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titleTextStyle: GoogleFonts.rajdhani(color: Colors.black),
              icon: Icon(Icons.error_outline, color: Colors.black,),
              title: Text('Uygulamayı Kullanabilmeniz için konum verilerine izin vermiş olmanız gerekmektedir', style: GoogleFonts.rajdhani(),),
            );
          },
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.info_outline, color: Colors.black,),
            title: Text('Lütfen Ayarlardan Konum Hizmetlerine İzin Verin!', style: GoogleFonts.rajdhani(),),
          );
        },
      );
      return;
    }
    _positionStream = Geolocator.getPositionStream().listen(_onPositionUpdate);
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("tr-TR"); // Dil ayarlaması
    await flutterTts.setPitch(1); // Ses perdesi
    await flutterTts.setSpeechRate(0.7); // Konuşma hızı
    await flutterTts.speak(text); // Metni oku
   await flutterTts.setVolume(decibel as double);
  }

  void dispose() {
    super.dispose();
    flutterTts.stop();
    _positionStream?.cancel();
  }

  void _onPositionUpdate(Position position) {

    for(RiskPoint risk_point in risk_points!) {

      double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          risk_point.xKoordinat,
          risk_point.yKoordinat
      );



      int distanceValue;

      if(speed.round() >= 0 && speed.round() <= 80){
        distanceValue = 250;
      }
      else if(speed.round() >= 81 && speed.round() <= 100) {
        distanceValue = 400;
      }
      else if(speed.round() >= 101 && speed.round() <= 120){
        distanceValue = 700;
      }
      else if(speed.round() >= 121 && speed.round() >= 140){
        distanceValue = 1000;
      }
      else{
        distanceValue = 1250;
      }

      if (distance <= distanceValue) {
        _showWarning();
        setState(() {
          error_message = risk_point.kazaSekli.first.kazaTipi;
        });
        Timer(const Duration(seconds: 10), () {
          _hideWarning();
        });
      }
    }
  }

  void _showWarning() {
    setState(() {
      _showingWarning = true;
    });
  }
  void _hideWarning() {
    setState(() {
      _showingWarning = false;
    });
  }


  Widget build(BuildContext context) {
    if(completed){
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                compassEnabled: false,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                buildingsEnabled: true,
                trafficEnabled: traffic,
                mapType: mapType,
                initialCameraPosition: _cameraPosition,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                scrollGesturesEnabled: true,
                onMapCreated: (map){},
                polygons: {ankara},
                circles: Set.from(_circles),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppBarWidget(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildWarning(error_message),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white.withOpacity(0.7)
                    ),
                    child: Text(speed.round().toString(), style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ),
          // floatingActionButton: const AnimationFloatingActionButton(),

        ),
      );
    }else{
      return Container();
    }
  }



 //






Set<Circle> circleSet(){
  return <Circle>{

  };
}
}

