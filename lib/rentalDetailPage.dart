import 'package:flutter/material.dart';
import 'package:rentiq/addNewApt.dart';
import 'constants.dart';

class RentalDetails extends StatefulWidget {
  RentalDetails({this.doorNo,this.tenantName});
  final int doorNo;
  final String tenantName;
  @override
  _RentalDetailsState createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Agane'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kAptNumCardColor,
          centerTitle: true,
          title: Stack(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                child: Text(
                  'Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewApt()));
                    print('Tenant detail edit pressed');
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text(
                    'Door No: ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agane',
                    ),
                  ),
                  Text(
                    '${widget.doorNo}',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Agane',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agane',
                    ),
                  ),
                  Text(
                    '${widget.tenantName}',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Agane',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agane',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kAptNumCardColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                ),
                width: double.infinity,
                height: 1000,
                child: ListView(
                  padding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Rental Detail',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RentalDetailCard(text: 'Rent: Rs.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RentalDetailCard(text: 'Water Tax: Rs.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RentalDetailCard(text: 'Parking: Rs.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RentalDetailCard(text: 'Maitenance Rs.',)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Rs.',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Electricity Readings:',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        kMakeTextField(labelTextHolder: ''),
                      ],
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),
                      color: Colors.grey[800],
                      onPressed: (){},
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RentalDetailCard extends StatefulWidget {
  RentalDetailCard({this.text});
  final String text;
  @override
  _RentalDetailCardState createState() => _RentalDetailCardState();
}

class _RentalDetailCardState extends State<RentalDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.white,
      ),
    );
  }
}
