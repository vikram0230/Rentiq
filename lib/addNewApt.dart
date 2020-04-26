import 'package:flutter/material.dart';
import 'constants.dart';

class AddNewApt extends StatefulWidget {

  @override
  _AddNewAptState createState() => _AddNewAptState();
}
class _AddNewAptState extends State<AddNewApt> {
  final _controller = TextEditingController();
  @override
  void initState() {
    _controller.addListener((){
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(
                'Add New Apartment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kAptNumCardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
          body: EditDetails(),
      ),
    );
  }
}


class EditDetails extends StatefulWidget {
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
      child: Column(
        children: <Widget>[
          kMakeTextField(labelTextHolder: 'Rental Number'),
          kMakeTextField(labelTextHolder: 'Name'),
          kMakeTextField(labelTextHolder: 'Phone Number'),
          Text('Rent Details:'),
          kMakeAdjacentFormField(labelText: 'Rent: Rs.'),
          kMakeAdjacentFormField(labelText: 'Water tax: Rs.'),
          kMakeAdjacentFormField(labelText: 'Parking: Rs.'),
          FlatButton(
            child: Text('+ Add Field'),
            onPressed: () {
              setState(() {

              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: kAptNumCardColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: FlatButton(
                    onPressed: () {},
                    color: kAptNumCardColor,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}