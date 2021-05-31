
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpashState();
  }
}

class SpashState extends State<SplashView> {

  @override
  void initState() {
    _timer();
    super.initState();
  }

  void _timer () async{
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4f80ff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/svg/logoInv.svg'),
          )
        ],
      ),
    );
  }
}