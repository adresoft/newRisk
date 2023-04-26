import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:risk/risk_points/risk_points.dart';


riskPointBottomSheet(BuildContext context, List<KazaSekli> kazaSekilleri){
  kazaSekilleri.forEach((element) {
    debugPrint(element.kazaTipi);
  });
  debugPrint("//////////////");
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Center(
          child: ListView(
          children: <Widget>[
            ListTile(leading: Icon(Icons.info_outline, color: Colors.black,), title: Text('Risk Noktası', style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),)),
          //  Row(children: [Text(x.toString(), style: GoogleFonts.rajdhani(color: Colors.indigo),),Text(y.toString(), style: GoogleFonts.rajdhani(color: Colors.indigo),),],),
            const Divider(color: Colors.black,),
            ListTile(
              leading: Icon(Icons.emergency_share_rounded, color: Colors.black,),
              title: Text('Kaza Sebepleri', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
              subtitle: ListView.builder(shrinkWrap: true,itemBuilder: (context, index) => ListTile(leading: Text('% ${kazaSekilleri[index].yuzde}', style: GoogleFonts.rajdhani(),), title: Text('${kazaSekilleri[index].kazaTipi}',style: GoogleFonts.rajdhani(),), trailing: Text('${kazaSekilleri[index].adet}', style: GoogleFonts.rajdhani(),)), itemCount: kazaSekilleri.length),
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
        ),
      );
    },
  );
}