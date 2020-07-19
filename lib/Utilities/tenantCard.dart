import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentiq/Pages/rentalDetail.dart';
import 'DatabaseHelper.dart';
import 'Rental.dart';
import 'constants.dart';

class TenantCard extends StatefulWidget {
  TenantCard({this.rental});
  final Rental rental;

  @override
  _TenantCardState createState() => _TenantCardState();
}

class _TenantCardState extends State<TenantCard> {

  Color getColor(){
    if(widget.rental.status == 'to_be_noted') {return  Colors.red;}
    else if(widget.rental.status == 'Noted') {return Colors.yellow;}
    else if(widget.rental.status == 'SMS'){return Colors.green;}
  }

  Icon getIcon(){
    if(widget.rental.occupied == 1){
      return Icon(Icons.bookmark,color: getColor(),size: 25);
    }
    else{
      return Icon(Icons.bookmark_border,color: Colors.white,size: 25);
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper database = DatabaseHelper(rental: widget.rental);
    database.getBillItems();
    database.getElectricityReadings();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: RaisedButton(
        elevation: 15.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(0.0),
        color: kAptCardColor,
        hoverColor: kAptCardHoverColor,
        onPressed: (){
          Navigator.push(context,MaterialPageRoute( builder: (context) => RentalDetails(rental: widget.rental, icon: getIcon(),),),);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 95.0,
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.ideographic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'No.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.rental.rentalNo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    getIcon(),
                  ],
                ),
                ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.rental.tenantName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 33.0,
                            fontWeight: FontWeight.bold,
                            color: kWidgetCardTextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Text(
                          widget.rental.address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ]
        ),
      ),
    );
  }
}

