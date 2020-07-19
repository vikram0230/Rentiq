import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentiq/Pages/EditRental.dart';
import 'package:rentiq/Utilities/DatabaseHelper.dart';
import 'package:rentiq/Utilities/Rental.dart';
import 'package:rentiq/Utilities/Rental_Detail_Card.dart';
import 'package:rentiq/Utilities/constants.dart';
import 'package:rentiq/Utilities/Tenant_Detail_Card.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:rentiq/Utilities/Electricity_Button_Card.dart';

class RentalDetails extends StatefulWidget {
  static String id = 'Rental Details';
  RentalDetails({this.rental,this.icon});
  final Rental rental;
  final Icon icon;
  @override
  _RentalDetailsState createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {

  Widget showElectricity(){
    DateTime date = DateTime.now();
    String usableDate = date.month.toString() + '-' + date.year.toString();
      if(widget.rental.dateEB == usableDate){
        total += widget.rental.electricityCost;
        return RentalDetailCard(text: 'Electricity :', value: widget.rental.electricityCost.toString(),);
      }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElectricityButtonCard(context: context, rental: widget.rental),
    );
  }

  static const platform = const MethodChannel('sendSms');
  Future sendSms() async{
    print('SendSMS');
    try{
      final String result = await platform.invokeMethod('send', <String,dynamic>{"phone":"+919840148399", "msg":"Hello"});
      print(result);
    } on PlatformException catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper database = DatabaseHelper(rental: widget.rental);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Agane'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kAptNumCardColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            }),
          title: Text(
            'Tenant Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditRental(rental: widget.rental,)));
                },),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TenantDetailCard(text: 'Rental No: ', value: widget.rental.rentalNo,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: widget.icon,
                      ),
                    ],
                  ),
                  TenantDetailCard(text: 'Name: ', value: widget.rental.tenantName,),
                  TenantDetailCard(text: 'Phone Number: ', value: widget.rental.phoneNo,),
                  TenantDetailCard(text: 'Address: ', value: widget.rental.address,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kAptNumCardColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                ),
                width: mediaQuery.size.width,
                height: 1000,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Rental Bill',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FutureBuilder(
                            future: database.getBillItems(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: LoadingBouncingGrid.circle(backgroundColor: Colors.white70,),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text('Loading...',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return ListView(
                                children: billItemCardList,
                                physics: BouncingScrollPhysics(),
                              );
                            },
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: database.getElectricityReadings(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          return showElectricity();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 1, 0, 9),
                        child: Container(
                          height: 0.5,
                          color: Colors.grey[800],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total :',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Rs.',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: database.getElectricityReadings(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot){
                                      return Text(
                                        '$total',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: kAptNumCardColor,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlineButton(
                    borderSide: BorderSide(
                      width: 3,
                      color: kButtonColor,
                    ),
                    highlightedBorderColor: Colors.white70,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),
                    onPressed: (){
                      DatabaseHelper database = DatabaseHelper(rental: widget.rental);
                      database.updateMaster();
                      DateTime date = DateTime.now();
                      String usableToday = date.month.toString() + '-' + date.year.toString();
                      if(widget.rental.dateBill != usableToday) {
                        database.addBillItems();
                        //TODO: ALERT - Current month bill saved
                      }
                      else
                        print('Already saved');
                      //TODO: ALERT - Current month bill already saved
                    },
                    child: Container(
                      height: 60,
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),
                    color: kButtonColor,
                    onPressed: () => sendSms(),
                    child: Container(
                      height: 60,
                      child: Center(
                        child: Text(
                          'SMS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



