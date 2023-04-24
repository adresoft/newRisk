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
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: ()=> Navigator.pop(context),icon: Icon(Icons.clear)),
            backgroundColor: Colors.red,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.chat_bubble_outline), child: Text('Geri Bildirim', style: GoogleFonts.quicksand(),),),
                Tab(icon: Icon(Icons.verified_user) ,child: Text('Kullanıcı Sözleşmesi', style: GoogleFonts.quicksand(),),),
                Tab(icon: Icon(Icons.info_outline),child: Text('Proje Hakkında', style: GoogleFonts.quicksand(),),),
              ],
            ),
          ),
          body: TabBarView(

            children: [
              Container(child: Column(
                children: [Center(child: Text('Page'),)],
              )),
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
