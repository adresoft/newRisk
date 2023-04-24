import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'google_maps_view.dart';

double speed = 0;

StreamSubscription<Position>? positionStreamSubscription;

void startListening() {
  positionStreamSubscription =
      Geolocator.getPositionStream().listen((Position position) {
        double speedInKmh = position.speed * 3.6;
        speed = speedInKmh;
      });
}

void stopListening() {
  positionStreamSubscription?.cancel();
}


class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        appbarContainer(),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: speedContainer(),
            ),
            Expanded(child:
            Container()),
            Expanded(
              child: dateContainer(),
            ),
          ],
        ),
      ],
    );
  }

  Container appbarContainer() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:  ListTile(
          leading: CircleAvatar(backgroundColor: Colors.white,child: Image.asset('assets/images/teknofest.png'),),
          title: Text('Trafik Risk Bilgi Sistemi', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),
          subtitle: Text('Akıllı Ulaşım Yarışması', style: GoogleFonts.rajdhani(),),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Icarus', style: GoogleFonts.rajdhani(),),
              Text('${DateTime.now().hour}.${DateTime.now().minute}', style: GoogleFonts.rajdhani(),),
            ],
          ),
        ),
      );
  }

  Container dateContainer() {
    return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Icon(Icons.hourglass_empty, color: Colors.black,),
                    const SizedBox(width: 2,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold, color: Colors.black,),),
                        Text('${DateTime.now().hour}.${DateTime.now().minute}', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold, color: Colors.black, ),),
                      ],
                    ),]
              ),
            );
  }

  Container speedContainer() {
    return Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(leading: const Icon(Icons.speed, color: Colors.black,),title: Text(speed.round().toString(), style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),),),
            );
  }
}


