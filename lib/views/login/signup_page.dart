
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';

class SignUpPageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPageView> {

  TextEditingController nameTextC = new TextEditingController();
  TextEditingController emailTextC = new TextEditingController();
  TextEditingController passwordTextC = new TextEditingController();
  TextEditingController password2TextC = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //TODO: Make it go upity up
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
                          InputField(nameTextC, 'Name'),
                          SizedBox(height: 20,),
                          InputField(emailTextC, 'Email'),
                          SizedBox(height: 20,),
                          InputField(passwordTextC, 'Password'),
                          SizedBox(height: 20,),
                          InputField(password2TextC, 'Confirm Password'),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A53C2)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Sign up',
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
                              'Back to login',
                              style: smallText,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: IgnorePointer(
                    child: SvgPicture.asset('assets/svg/lower_decor.svg'),
                  ),
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
                        'Sign up',
                        style: titleStyle,
                      ),
                    )
                ),

              ],
            ),
          )
      ),
    );
  }
}