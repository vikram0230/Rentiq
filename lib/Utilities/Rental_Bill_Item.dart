import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rental_Bill_Item extends StatelessWidget {
  Rental_Bill_Item({this.labelText,this.initialText});
  final String labelText;
  final String initialText;
  double amount;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: initialText);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: <Widget>[
        Text(labelText,
          style: TextStyle(
              fontSize: 17
          ),
        ),
        Container(
          width: (labelText.length < 15)? 250 : 200,
          child: TextField(
            controller: _controller,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            onChanged: (value){
              amount = double.parse(value);
            },
            decoration: InputDecoration(
              prefixText: (labelText != 'EB Meter Reading :')? 'Rs. ' : null,
              suffixText: (labelText == 'EB Meter Reading :')? 'units' : null,
              prefixStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              suffixStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              focusColor: Colors.black,
              hoverColor: Colors.black,
              focusedBorder: UnderlineInputBorder()
            ),
          ),
        ),
      ],
    );
  }
}