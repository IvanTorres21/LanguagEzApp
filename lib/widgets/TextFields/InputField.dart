import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget{

  TextEditingController textC;
  bool obscure = false;
  String label;

  InputField(this.textC, this.label, {this.obscure});

  @override
  State<StatefulWidget> createState() {
    return InputFieldState();
  }
}

class InputFieldState extends State<InputField> {


  @override
  Widget build(BuildContext context) {
    return  Material(
        elevation: 5.0,
        borderRadius:  const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            obscureText: this.widget.obscure != null ? this.widget.obscure : false,
            controller: this.widget.textC,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: this.widget.label,
            ),
          ),
        )
    );
  }

}