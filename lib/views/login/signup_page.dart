
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/utility/user_controller.dart';
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
  UserController _userController = new UserController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                            InputField(passwordTextC, 'Password', obscure: true),
                            SizedBox(height: 20,),
                            InputField(password2TextC, 'Confirm Password', obscure: true),
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
                                onPressed: ()  async {
                                  User user = new User();
                                  user.email = emailTextC.text;
                                  user.username = nameTextC.text;
                                  print('Password: ${passwordTextC.text} Password2: ${password2TextC.text}');
                                  if(passwordTextC.text.compareTo(password2TextC.text) == 0) {
                                    user.password = passwordTextC.text;
                                    if(user.email.isNotEmpty && user.password.isNotEmpty && user.username.isNotEmpty) {
                                      bool logged = await _userController.signUp(user);
                                      if(logged) {
                                        Navigator.pushNamed(context, '/home');
                                      } else {
                                        await _dialog('Couldn\'t sign up');
                                      }
                                    } else {
                                      await _dialog('Empty fields');
                                    }
                                  } else {
                                    await _dialog('Passwords don\'t match!');
                                  }

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
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2.7,
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
      ),
    );
  }

  /// Makes a dialog box
  Future<void> _dialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}