import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int decibel = 1;
String warningMessage = 'Hepsi';
bool powerMode = false;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white,),),
      title: Row(
        children: [
          // const Icon(Icons.settings, color: Colors.white,),
          Text('Settings', style: GoogleFonts.rajdhani(color: Colors.white, fontWeight: FontWeight.bold),),
        ],
      ),
        centerTitle: true,
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.more_vert, color: Colors.white,))
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.earbuds, color: Colors.black,),
            title: Text('Risk Uyarısı Desibeli:', style: GoogleFonts.rajdhani(color: Colors.black),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () => setState(() {
                  decibel == 0 ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Desibel 0\'dan düşük olamaz!'))) : decibel--;
                }), icon: const Icon(Icons.arrow_back_ios,color: Colors.black,), style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),),
                Text(decibel.toString(), style: GoogleFonts.rajdhani(color: Colors.black),),
                IconButton(onPressed: () => setState(() {
                  decibel == 30 ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Desibel 30\'dan büyük olamaz!'))) : decibel++;
                }), icon: const Icon(Icons.arrow_forward_ios, color: Colors.black,), style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),)
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.error_outline, color: Colors.black,),
            title: Text('Risk Noktası Uyarısı:', style: GoogleFonts.rajdhani(color: Colors.black),),
            trailing: TextButton(
              onPressed: () => setState(() {
                switch (warningMessage){
                  case 'Hepsi':
                    warningMessage = 'Turuncu ve Kırmızı';
                    break;
                  case 'Turuncu ve Kırmızı':
                    warningMessage = 'Sadece Kırmızı';
                    break;
                  case 'Sadece Kırmızı':
                    warningMessage = 'Hiçbiri';
                    break;
                  default:
                    warningMessage = 'Hepsi';
                    break;
                }
              }),
              child: Text(warningMessage, style: GoogleFonts.quicksand(color: Colors.black),),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new, color: Colors.black,),
            title: Text('Güç Tasarrufu Modu: ', style: GoogleFonts.rajdhani(color: Colors.black),),
            trailing: TextButton(
              onPressed: () => setState(() {
                powerMode = !powerMode;
              }),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: Text(powerMode == true ? 'Açık' : 'Kapalı', style: GoogleFonts.rajdhani(color: Colors.black), ),
            ),
          ),
        ],
      ),
    ));
  }
}
