import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void riskPointBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.black,),
              title: Text('Hasanoğlan Bahçelievler, 06850 Elmadağ/Ankara'+' '+'', style: GoogleFonts.rajdhani(),),
            ),
            ListTile(
              leading: Icon(Icons.emergency_share_rounded, color: Colors.black,),
              title: Text('Kaza Sebepleri', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('%54 Kaza Sebep 1', style: GoogleFonts.rajdhani(),),
                  Text('%31 Kaza Sebep 2', style: GoogleFonts.rajdhani(),),
                  Text('%10 Kaza Sebep 3', style: GoogleFonts.rajdhani(),),
                  Text('%54 Kaza Sebep 4', style: GoogleFonts.rajdhani(),),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit, color: Colors.grey,),
              title: Text('Kazaların Yaşandığı Tarihler', style: GoogleFonts.quicksand(color: Colors.grey),),
            trailing: Text('Çok Yakında!', style: GoogleFonts.quicksand(color: Colors.red),),
            ),
            ListTile(
              leading: Icon(Icons.access_time_outlined, color: Colors.grey,),
              title: Text('Kazaların Yaşandığı Saatler', style: GoogleFonts.quicksand(color: Colors.grey),),
              trailing: Text('Çok Yakında!', style: GoogleFonts.quicksand(color: Colors.red),),
            ),
            ListTile(
              leading: Icon(Icons.cloud, color: Colors.grey,),
              title: Text('Kazaların Yaşandığı Hava Durumu', style: GoogleFonts.quicksand(color: Colors.grey),),
              trailing: Text('Çok Yakında!', style: GoogleFonts.quicksand(color: Colors.red),),
            ),
          ],
        ),
      );
    },
  );
}