import 'package:flutter/material.dart';

Color kBackgroundColor = Colors.white;
Color kAptCardColor = Colors.white;
Color kAptNumCardColor = Color(0xFF121212);
Color kAptCardHoverColor = Colors.pink;
Color kWidgetCardTextColor = Colors.black;
Color kRentDetailCardColor = Colors.grey[200];

Widget kMakeAdjacentFormField({String labelText}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Text(labelText),
      ),
      kMakeTextField(),
    ],
  );
}

Widget kMakeTextField({String labelTextHolder}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Colors.white,
        onChanged: (value){},
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
          ),
          labelText: labelTextHolder,
        ),
      ),
    ),
  );
}