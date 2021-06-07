
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/user_controller.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpashState();
  }
}

class SpashState extends State<SplashView> {

  UserController _userController = UserController();

  @override
  void initState() {
    _timer();
    super.initState();
  }

  void _timer () async{
    String route = '/login';
    if(await _userController.autoLogin())
      route = '/home';
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushNamed(context, route);
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