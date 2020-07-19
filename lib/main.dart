import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentiq/Pages/addNewApt.dart';
import 'Pages/AptPage.dart';
import 'Pages/rentalDetail.dart';
import 'Pages/EditRental.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Agane'),
      initialRoute: AptPage.id,
      routes: {
        AptPage.id: (context) => AptPage(),
        AddNewApt.id: (context) => AddNewApt(),
        RentalDetails.id: (context) => RentalDetails(),
        EditRental.id: (context) => EditRental(),
      },
    );
  }
}

