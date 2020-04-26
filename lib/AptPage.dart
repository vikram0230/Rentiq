import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rentiq/addNewApt.dart';
import 'constants.dart';
import 'AptWidgetCard.dart';

class AptPage extends StatefulWidget {
  @override
  _AptPageState createState() => _AptPageState();
}
class _AptPageState extends State<AptPage> {
  static bool deleteSelector = false;
  List<AptWidgetCard> rentalList = [
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 101,deleteSelector: deleteSelector),
    AptWidgetCard(tenantName: 'Tony Stark',doorNo: 102,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Bruce Wayne',doorNo: 103,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 104,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 105,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 106,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 107,deleteSelector: deleteSelector,),
    AptWidgetCard(tenantName: 'Chris Hemsworth',doorNo: 108,deleteSelector: deleteSelector,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Stack(
            children: <Widget>[
              Container(
                  child: Center(
                    child: Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kAptNumCardColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.drag_handle,
                    color: kAptNumCardColor,
                  ),
                  color: kAptNumCardColor,
                  padding: EdgeInsets.all(0.0),
                  onSelected: (String result) {
                    setState(() {
                      if(result == 'Add'){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewApt(),fullscreenDialog: true));
                      }
                      if(result == 'Delete'){
                        deleteSelector = true;
                      }
                      print(result);
                    },);
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Add',
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
        body: ListView(
          children:
            rentalList,
        )
    );
  }
}




