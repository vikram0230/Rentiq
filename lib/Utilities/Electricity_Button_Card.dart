import 'package:flutter/material.dart';
import 'package:rentiq/Utilities/DatabaseHelper.dart';
import 'constants.dart';
import 'package:rentiq/Utilities/Rental.dart';

class ElectricityButtonCard extends StatelessWidget {
  const ElectricityButtonCard({Key key, @required this.context,this.rental}) : super(key: key);
  final BuildContext context;
  final Rental rental;

  @override
  Widget build(BuildContext context) {
    double ebValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text('Electricity :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
          color: kButtonColor,
          onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                backgroundColor: Colors.black,
                title: Center(
                  child: Text('Electricity Bill',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Last Month Reading: ',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Text(' ${rental.previousEB} units',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text('Current Month Reading: ',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            onChanged: (value){
                              ebValue = double.parse(value);
                            },
                            decoration: InputDecoration(
                              suffixText: '  units',
                              suffixStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text('Cancel'),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  FlatButton(
                    onPressed: (){
                      if(rental.currentEB != null)
                        rental.previousEB = rental.currentEB;
                      rental.currentEB = ebValue;
                      DatabaseHelper database = DatabaseHelper(rental: rental);
                      database.addElectricity();
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ],
                insetPadding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              );
            });
          },
          child: Container(
            child: Text('Calculate',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
