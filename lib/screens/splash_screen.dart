import 'package:flutter/material.dart';
import 'package:risk/screens/map/google_maps_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GoogleMapsView(),));});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.asset('assets/images/teknofest.png'),
          ),
          Center(
            child: Row(
              children: [


              ],
            ),
          ),
        ],
      ),
    );
  }
}
