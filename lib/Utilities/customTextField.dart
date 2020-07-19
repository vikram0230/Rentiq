import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.labelText,this.inputType,this.initialText});
  final String labelText;
  final TextInputType inputType;
  final String initialText;
  String text;

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(text: initialText);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        autofocus: false,
        controller: textController,
        onChanged: (value){
          text = value;
        },
        keyboardType: inputType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
            )
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          suffixIcon: IconButton(icon: Icon(Icons.clear,color: Colors.black,), onPressed: (){textController.clear();})
        ),
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}