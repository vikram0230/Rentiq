import 'package:flutter/material.dart';

class TenantDetailCard extends StatelessWidget {
  TenantDetailCard({this.text, this.value});
  final String text;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Agane',
            ),
          ),
          Flexible(
            child: Text(
              value,
              softWrap: true,
              style: TextStyle(
                  fontSize: (value.length < 20)? 20.0 : 16,
                  fontFamily: 'Agane',
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
