import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentiq/rentalDetailPage.dart';
import 'constants.dart';

class AptWidgetCard extends StatefulWidget {
  AptWidgetCard({this.doorNo,this.tenantName,this.deleteSelector});
  final String tenantName;
  final int doorNo;
  final bool deleteSelector;

  @override
  _AptWidgetCardState createState() => _AptWidgetCardState();
}

class _AptWidgetCardState extends State<AptWidgetCard> {
  bool check = false;
  @override
  Widget build(BuildContext context) {

    Icon getCheckBox(){
      if(check){
        return Icon(
          Icons.check_box,
          color: kWidgetCardTextColor,
          size: 40.0,
        );
      }
      else{
        return Icon(
          Icons.check_box_outline_blank,
          color: kWidgetCardTextColor,
          size: 40.0,
        );
      }
    }

    Icon determineDelete(){
      if(widget.deleteSelector){
        return getCheckBox();
      }
      else{
        return null;
      }
    }

    return Container(
      height: 130.0,
      padding: EdgeInsets.only(top: 7.0,left: 5.0,right: 5.0),
      child: RaisedButton(
        elevation: 15.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(0.0),
        color: kAptCardColor,
        hoverColor: kAptCardHoverColor,
        onPressed: (){
          if(widget.deleteSelector){}
          else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => RentalDetails(tenantName: widget.tenantName,doorNo: widget.doorNo,),),);
          }
        },
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 95.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF121212),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),),
                    ),
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
                            '${widget.doorNo}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                      child:Stack(
                        children: <Widget>[
                          Text(
                            widget.tenantName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 33.0,
                              fontWeight: FontWeight.bold,
                              color: kWidgetCardTextColor,
                            ),
                          ),

                        ],
                      )
                  ),
                ),
                ]
            ),
          ],
        ),
        ),
      );
  }
}


class Rental{
  int rentalNo;
  String name;
  int phNo;
  List<String> attributes;
  List<int> values;

  int getRentalNo(){return rentalNo;}
  String getName(){return name;}
  int getPhNo(){return phNo;}
  void addField(String attr,int value){
    attributes.add(attr);
    values.add(value);
  }
}
