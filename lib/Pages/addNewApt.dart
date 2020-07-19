import 'package:flutter/material.dart';
import 'package:rentiq/Utilities/DatabaseHelper.dart';
import '../Utilities/constants.dart';
import 'package:rentiq/Utilities/Rental_Bill_Item.dart';
import 'package:rentiq/Utilities/customTextField.dart';
import 'package:rentiq/Utilities/Rental.dart';

class AddNewApt extends StatefulWidget {
  static String id = 'Add New';
  @override
  _AddNewAptState createState() => _AddNewAptState();
}
class _AddNewAptState extends State<AddNewApt> {

  List<CustomTextField> tenantDetails = [
    CustomTextField(labelText: 'Rental Number',inputType: TextInputType.text,),
    CustomTextField(labelText: 'Name', inputType: TextInputType.text),
    CustomTextField(labelText: 'Phone Number', inputType: TextInputType.phone),
    CustomTextField(labelText: 'Address', inputType: TextInputType.text),
  ];
  List<Rental_Bill_Item> rentDetails = [
    Rental_Bill_Item(labelText: 'Rent :'),
    Rental_Bill_Item(labelText: 'Water tax :'),
    Rental_Bill_Item(labelText: 'Maintenance :'),
  ];

  // ignore: non_constant_identifier_names
  Rental_Bill_Item EbReading = Rental_Bill_Item(labelText: 'EB Meter Reading :',);

  Rental rental = Rental();
  void getValues(){
      rental.rentalNo = tenantDetails[0].text;
      rental.tenantName = tenantDetails[1].text;
      rental.phoneNo = tenantDetails[2].text;
      rental.address = tenantDetails[3].text;
      rental.occupied = 1;
      rental.status = 'to_be_noted';
      rental.rpu = 7;
      if(rentDetails != null){
        rental.billItems = {};
        for(var i in rentDetails){
          rental.billItems[i.labelText] = i.amount;
        }
      }
      rental.previousEB = EbReading.amount;
      rental.currentEB = null;
      rental.electricityCost = 0;
  }

  Widget _buildBottomSheet(BuildContext context){
    String newField;
    TextEditingController bottomSheetController = TextEditingController();
    return Container(
      height: 500,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add Field',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 70, 30),
              child: TextField(
                controller: bottomSheetController,
                onChanged: (value){
                  newField = value;
                },
                style: TextStyle(
                  fontSize: 18,
                ),
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                autofocus: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder()
                ),
              ),
            ),
            RaisedButton(
              color: Colors.black,
              onPressed: (){
                setState(() {
                  rentDetails.add(Rental_Bill_Item(labelText: newField +' :'));
                  Navigator.pop(context);
                });
              },
              child: Container(
                width: 70,
                height: 50,
                child: Center(
                  child: Text('Add',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Add New Rental',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
          body: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              Column(
                children: tenantDetails,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EbReading,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Rent Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: rentDetails,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: FlatButton(
                  child: Text('+ Add Field'),
                  onPressed: () {
                    showModalBottomSheet(context: context, builder: _buildBottomSheet);
                  },
                ),
              ),
            ],
          ),
        bottomNavigationBar:  Container(
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
                      // TODO: DIALOG - Confirmation for discard
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      child: Center(
                        child: Text(
                          'Cancel',
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
                    onPressed: (){
                      getValues();
                      DatabaseHelper database = DatabaseHelper(rental: rental);
                      database.addNewRental();
                      Navigator.pop(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
