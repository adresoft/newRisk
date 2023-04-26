import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(

        length: 2,
        child: Scaffold(
          appBar: TabBar(

            isScrollable: false,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              dividerColor: Colors.red,
              tabs: [
                Tab(icon: Icon(Icons.verified_user) ,child: Text('Kullanıcı Sözleşmesi', style: GoogleFonts.rajdhani(),),),
                Tab(icon: Icon(Icons.chat_bubble_outline), child: Text('Geri Bildirim ve İletişim', style: GoogleFonts.rajdhani(),),),

              ],
            ),

          body: TabBarView(

            children: [
              Container(child: Column(
                children: [Center(child: Text('Page'),)],
              )),
              Container(child: Column(
                children: [Center(child: Text('Page'),)],
              )),

            ],
          ),
        ),
      ),
    );
  }
}
