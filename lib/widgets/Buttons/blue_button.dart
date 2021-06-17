import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {

  void Function() onPressed;
  String title;


  BlueButton(this.onPressed, this.title);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A53C2)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '$title',
          style: TextStyle(color: Color(0xFFFAFAFA)),
        ),
      ),
      onPressed: onPressed,
    );
  }

}