import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

bool traffic = true;
String trafficMessage = traffic ? 'Etkin' : 'Devredışı';
MapType mapType = MapType.normal;

void mapSettingsBottomSheet(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harita Ayarları',
                  style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => mapType = MapType.normal,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/normal.jpeg'),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Text(
                            'Varsayılan',
                            style: GoogleFonts.rajdhani(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => mapType = MapType.hybrid,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/hybrid.jpeg'),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Text(
                            'Uydu',
                            style: GoogleFonts.rajdhani(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => mapType = MapType.none,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/none.jpeg'),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Text(
                            'Tanımsız',
                            style: GoogleFonts.rajdhani(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                    title: Text(
                      'Trafik Haritası',
                      style: GoogleFonts.quicksand(color: Colors.black),
                    ),
                    trailing: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () => traffic = !traffic,
                        child:Text(
                                traffic ? 'Etkin' : 'Devredışı',
                                style:
                                    GoogleFonts.quicksand(color: Colors.black),
                        ),
                    ),),
              ],
            ),
          ],
        ),
      );
    },
  );
}
