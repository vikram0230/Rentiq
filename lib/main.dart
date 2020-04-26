import 'package:flutter/material.dart';
import 'AptPage.dart';
//import 'package:rentiq/addNewApt.dart';
//import 'constants.dart';
//import 'AptWidgetCard.dart';
//import 'rentalDetailPage.dart';
//import 'package:intro_slider/intro_slider.dart';
//import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Agane'),
      home: AptPage(),
    );
  }
}

