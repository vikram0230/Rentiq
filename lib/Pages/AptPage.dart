import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:flutter/rendering.dart';
import 'package:rentiq/Pages/addNewApt.dart';
import 'package:rentiq/Utilities/Custom_Drawer.dart';
import 'package:rentiq/Utilities/constants.dart';
import 'package:rentiq/Utilities/DatabaseHelper.dart';
import 'package:loading_animations/loading_animations.dart';

class AptPage extends StatefulWidget {
  static String id = '/';
  @override
  _AptPageState createState() => _AptPageState();
}
class _AptPageState extends State<AptPage> {

  // Drawer Methods
  FSBStatus drawerStatus;
  void closeDrawer(){
    setState(() {
      drawerStatus = FSBStatus.FSB_CLOSE;
    });
  }
  void closeDrawerAddTenant(){
    closeDrawer();
    Navigator.pushNamed(context, AddNewApt.id);
  }

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu,),
              color: kAptNumCardColor,
              onPressed: (){
                setState(() {
                  drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
                });
              }
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Rentiq',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAptNumCardColor,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FoldableSidebarBuilder(
          status: drawerStatus,
          drawer: CustomDrawer(closeDrawer: closeDrawer, closeDrawerAddTenant: closeDrawerAddTenant,),
          screenContents: FutureBuilder(
            future: database.getRentalList(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: LoadingBouncingGrid.circle(
                        backgroundColor: Colors.grey[800],
                      ),
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
              else{
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: tenantCardList,
                );
              }
            },
          ),
        ),
    );
  }
}



