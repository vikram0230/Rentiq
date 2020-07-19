import 'package:flutter/material.dart';
import '../Utilities/constants.dart';
import 'package:rentiq/Utilities/Rental_Bill_Item.dart';
import 'package:rentiq/Utilities/customTextField.dart';
import 'package:rentiq/Utilities/Rental.dart';
import 'package:rentiq/Utilities/Tenant_Detail_Card.dart';
import 'package:rentiq/Utilities/DatabaseHelper.dart';
import 'package:rentiq/Pages/AptPage.dart';

class EditRental extends StatefulWidget {
  EditRental({this.rental});
  final Rental rental;
  static String id = 'EditRental';
  @override
  _EditRentalState createState() => _EditRentalState();
}

class _EditRentalState extends State<EditRental> {

  List<CustomTextField> tenantDetails = [];
  List<Rental_Bill_Item> rentDetails = [];
  int _occupied;

  @override
  void initState() {
    super.initState();
    _occupied = widget.rental.occupied;
    tenantDetails = [
      CustomTextField(labelText: 'Name', inputType: TextInputType.text, initialText: widget.rental.tenantName,),
      CustomTextField(labelText: 'Phone Number', inputType: TextInputType.phone, initialText: widget.rental.phoneNo),
    ];
    for(var i in widget.rental.billItems.keys){
      rentDetails.add(Rental_Bill_Item(labelText: i, initialText: widget.rental.billItems[i].toString(),));
    }
  }

  void getValues(){
    if(_occupied != widget.rental.occupied && _occupied == 0){
      widget.rental.tenantName = 'XXXXXXXXXX';
      widget.rental.phoneNo = 'XXXXXXXXXX';
      widget.rental.status = 'to_be_noted';
      widget.rental.occupied = _occupied;
      print(widget.rental.tenantName);
      print(widget.rental.phoneNo);
    }
    else{
      if(_occupied != widget.rental.occupied)
        widget.rental.occupied = _occupied;
      if (tenantDetails[0].text != null) {
        widget.rental.tenantName = tenantDetails[0].text;
        print(widget.rental.tenantName);
      }
      if (tenantDetails[1].text != null) {
        widget.rental.phoneNo = tenantDetails[1].text;
        print(widget.rental.phoneNo);
      }
    }

    for(var i in rentDetails){
      if(i.amount != null){
        if(i.amount == 0)
          widget.rental.billItems.remove(i.labelText);
        else
          widget.rental.billItems[i.labelText] = i.amount;
      }
    }
    print(widget.rental.billItems);
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
            'Edit Rental',
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
            TenantDetailCard(text: 'Rental No: ', value: widget.rental.rentalNo),
            TenantDetailCard(text: 'Address: ', value: widget.rental.address),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Occupied : ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agane',
                    ),
                  ),
                  Switch(
                    value: _occupied == 1 ? true : false,
                    onChanged: (value){
                      setState(() {
                        _occupied = value ? 1 : 0;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            Column(
              children: tenantDetails,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 8, 130, 0),
              child: OutlineButton(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: (){
                  showDialog(
                      context: context, builder: (context){
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: Center(
                        child: Text('Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      content: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text('Do you really want to delete ${widget.rental.rentalNo}? ',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){Navigator.pop(context);},
                          child: Text('Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                          splashColor: Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        FlatButton(
                          onPressed: (){
                            DatabaseHelper database = DatabaseHelper(rental: widget.rental);
                            database.deleteRental();
                            Navigator.pushNamed(context, AptPage.id);
                          },
                          child: Text('Delete',style: TextStyle(color: Colors.red),),
                          splashColor: Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ],
                    );
                  }
                  );
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text('Delete',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
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
