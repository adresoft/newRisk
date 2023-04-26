import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import'dart:convert';

import '../screens/map/google_maps_view.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class RiskPoint{
  double xKoordinat;
  double yKoordinat;
  int kazaSayisi;
  List<KazaSekli> kazaSekli;

  RiskPoint({
    required this.xKoordinat,
    required this.yKoordinat,
    required this.kazaSayisi,
    required this.kazaSekli,
  });

  factory RiskPoint.fromJson(Map<String, dynamic> json) {
    var kazaSekliList = json['kazaSekli'] as List;


    List<KazaSekli> kazaSekli = kazaSekliList.map((i) => KazaSekli.fromJson(i)).toList();

    return RiskPoint(
      xKoordinat: json['xKoordinat'],
      yKoordinat: json['yKoordinat'],
      kazaSayisi: json['kazaSayisi'],
      kazaSekli: kazaSekli,
    );
  }
}

class KazaSekli {
  String kazaTipi;
  int adet;
  int yuzde;

  KazaSekli({
    required this.kazaTipi,
    required this.adet,
    required this.yuzde,
  });

  factory KazaSekli.fromJson(Map<String, dynamic> json) {
    return KazaSekli(
      kazaTipi: json['kazaTipi'],
      adet: json['Adet'],
      yuzde: json['%'],
    );
  }
}
