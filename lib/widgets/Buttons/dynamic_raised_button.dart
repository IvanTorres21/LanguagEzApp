
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';

class DynamicButton extends StatelessWidget {

  void Function() onPressed;
  String title;

  DynamicButton(this.onPressed, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Theme.of(context).backgroundColor,
              boxShadow:  [
                new BoxShadow(
                  offset: Offset.fromDirection(2),
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 1.0,
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                  title,
                style: cardStyle,
              ),
            )
        ),
        onTap: onPressed,
      )
    );
  }

}