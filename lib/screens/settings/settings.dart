import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
int decibel = 1;
String warningMessage = 'Hepsi';
bool powerMode = false;
bool traffic = true;
String trafficMessage = traffic ? 'Etkin' : 'Devredışı';
MapType mapType = MapType.normal;


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(child:
    DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(

          isScrollable: false,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          dividerColor: Colors.red,
          tabs: [
            Tab(icon: Icon(Icons.settings) ,child: Text('Genel Ayarlar', style: GoogleFonts.rajdhani(),),),
            Tab(icon: Icon(Icons.map), child: Text('Harita Ayarları', style: GoogleFonts.rajdhani(),),),

          ],
        ),

        body: TabBarView(

          children: [

            Container(child: Column(children: [ ListTile(
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
              ),],),),

            Container(

              child: Column(
                children: [


                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() {
                            mapType = MapType.normal;
                          }),
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
                          onTap: () => setState(() {
                            mapType = MapType.hybrid;
                          }),
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
                          onTap: () => setState(() {
                            mapType = MapType.none;
                          }),
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
                      onPressed: () => setState(() {
                        traffic = !traffic;
                      }),
                      child:Text(
                        traffic ? 'Etkin' : 'Devredışı',
                        style:
                        GoogleFonts.quicksand(color: Colors.black),
                      ),
                    ),)

                ],
              ),
            ),

          ],
        ),




      ),
    ));
  }
}
