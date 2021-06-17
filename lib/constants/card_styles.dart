import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration wordCard = BoxDecoration(
  borderRadius: BorderRadius.circular(7),
  color: Color(0xFFF9F9F9),
  boxShadow:  [
    new BoxShadow(
      offset: Offset.fromDirection(2),
      color: Color(0x552D2D2D),
      spreadRadius: 1.0,
      blurRadius: 1.0,
    ),
  ],
);