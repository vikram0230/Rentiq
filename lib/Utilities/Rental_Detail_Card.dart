import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RentalDetailCard extends StatefulWidget {
  RentalDetailCard({this.text, this.value});
  final String text;
  final String value;
  @override
  _RentalDetailCardState createState() => _RentalDetailCardState();
}

class _RentalDetailCardState extends State<RentalDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Rs.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
