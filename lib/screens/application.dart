import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:risk/screens/map/google_maps_view.dart';
import 'package:risk/screens/more/more.dart';
import 'package:risk/screens/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

Widget page = GoogleMapsView();

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: page,
        bottomNavigationBar: PersistentTabView(
          context,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(5.0),

          ),
          screens: [
           GoogleMapsView(),
            Settings(),
            Container(
              color: Colors.white,
              child: Center(
                child: Icon(Icons.info_outline),
              ),
            ),
            More(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.location_on_outlined),
              title: 'Google Maps',
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.settings),

              title: 'Ayarlar',
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.info_outline),

              title: 'Project About',
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.more_horiz),

              title: 'Daha Fazla',
              activeColorPrimary: Colors.black,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
          navBarStyle: NavBarStyle.style1,
          onItemSelected: (int index) {},
        ),
      ),
    );
  }
}
