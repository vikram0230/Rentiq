import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'package:rentiq/Pages/AptPage.dart';
import 'constants.dart';
import 'package:rentiq/Pages/addNewApt.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({this.closeDrawer, this.closeDrawerAddTenant});
  final Function closeDrawer;
  final Function closeDrawerAddTenant;
  TextEditingController _controller = TextEditingController();
  String deleteConfirm;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper database = DatabaseHelper();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            width: mediaQuery.size.width * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    onPressed: closeDrawerAddTenant,
                    color: kAptCardColor,
                    child: Text('Add',
                      style: TextStyle(
                        color: kAptNumCardColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    onPressed: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Center(
                            child: Text('Delete Database',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Enter \'CONFIRM\' to delete Database',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextField(
                                decoration: InputDecoration(
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
                                cursorColor: Colors.white,
                                controller: _controller,
                                onChanged: (value){deleteConfirm = value;},
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: (){Navigator.pop(context);},
                              child: Text('Cancel',style: TextStyle(color: Colors.white),),
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                            FlatButton(
                              onPressed: (){
                                if(deleteConfirm == 'CONFIRM'){
                                  database.deleteDB();
                                  Navigator.pushNamed(context, AptPage.id);
                                }
                                Navigator.pop(context);
                              },
                              child: Text('Delete',style: TextStyle(color: Colors.red),),
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        );
                      });
                    },
                    color: kAptCardColor,
                    child: Text('Delete',
                      style: TextStyle(
                        color: kAptNumCardColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: mediaQuery.size.height * 0.25,
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Electricity Reference',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.bookmark, color: Colors.red,),
                            Text('To be Noted')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.bookmark, color: Colors.yellow,),
                            Text('Noted')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.bookmark, color: Colors.green,),
                            Text('SMS sent')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.all(30),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: closeDrawer,)
      ],
    );
  }
}
