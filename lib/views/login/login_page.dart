
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:languageez_app/constants/text_styles.dart';

class LoginPageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPageView> {

  TextEditingController emailTextC = new TextEditingController();
  TextEditingController passwordTextC = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Positioned(
                  bottom: 60,
                  child: SvgPicture.asset('assets/svg/lower_decor.svg'),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Color(0xFF3A53C2),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Text(
                        'Login',
                        style: titleStyle,
                      ),
                    )
                ),
                ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 20),
                        child: SvgPicture.asset('assets/svg/logo.svg', width: 140,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          InputField(emailTextC, 'Email'),
                          SizedBox(height: 20,),
                          InputField(passwordTextC, 'Password'),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A53C2)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Color(0xFFFAFAFA)),
                                ),
                              ),
                              onPressed: () {
                                //TODO: DO LOGIN
                              },
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Don\'t have an account?',
                              style: smallText,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}