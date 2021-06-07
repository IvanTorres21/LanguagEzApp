
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/user_controller.dart';
import 'package:languageez_app/views/dictionary/dictionaries_page.dart';
import 'package:languageez_app/views/home_page.dart';
import 'package:languageez_app/views/languages/languages_page.dart';
import 'package:languageez_app/views/profile/profile_page.dart';

// ignore: must_be_immutable
class MainPageView extends StatefulWidget {

  int currPage = 0;
  MainPageView(this.currPage);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPageView> {

  UserController _userController = new UserController();
  Widget _currentScreen;
  int _currentPage;

  @override
  void initState() {
    _currentPage = this.widget.currPage;
    _getCurrPage();
    super.initState();
  }

  /// This function changes the current page we are showing
  void _getCurrPage() {
    print(_currentPage);
    switch(_currentPage) {
      case 0:
        _currentScreen = HomePageView();
        break;
      case 1:
        _currentScreen = LanguagePageView();
        break;
      case 2:
        _currentScreen = DictionaryPageView();
        break;
      case 3:
        _currentScreen = ProfilePageView();
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Tienes que hacer el drawer
    return Scaffold(
      drawer: Drawer(
        child:  Container(
          color: Color(0xFF384478),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'LanguagEz',
                      style: titleStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFFFAFAFA),
                  ),
                ),
                ListTile(
                  title: Text('Home', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/home.svg', width: 30,),
                  onTap: () {
                    _currentPage = 0;
                    _getCurrPage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Languages', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/graduation-hat.svg', width: 30,),
                  onTap: () {
                    _currentPage = 1;
                    _getCurrPage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Dictionary', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/book.svg', width: 30,),
                  onTap: () {
                    _currentPage = 2;
                    _getCurrPage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Profile', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/profile.svg', width: 30,),
                  onTap: () {
                    _currentPage = 3;
                    _getCurrPage();
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFFFAFAFA),
                  ),
                ),
                ListTile(
                  title: Text('Settings', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/settings.svg', width: 30,),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: Text('Language', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/languages.svg', width: 30,),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: Text('Dark Mode', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/mode.svg', width: 30,),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: Text('Help', style: drawerStyle,),
                  leading: SvgPicture.asset('assets/icons/help.svg', width: 30,),
                  onTap: () {
                  },
                ),
                ListTile(
                  title: Text('Log out', style: drawerStyle,),
                  leading: Icon(Icons.logout, size: 30, color: Color(0xFFFAFAFA),),
                  onTap: () async {
                    if(await _userController.logOut())
                      Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
          )
        )
      ),
      body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                _currentScreen,
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Color(0xFF3A53C2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon:SvgPicture.asset('assets/icons/home.svg'),
                            color: Color(0xFFFAFAFA),
                            onPressed: () {
                              _currentPage = 0;
                              _getCurrPage();
                            }
                        ),
                        IconButton(
                            icon: SvgPicture.asset('assets/icons/graduation-hat.svg'),
                            color: Color(0xFFFAFAFA),
                            onPressed: () {
                              _currentPage = 1;
                              _getCurrPage();
                            }
                        ),
                        IconButton(
                            icon: SvgPicture.asset('assets/icons/book.svg'),
                            color: Color(0xFFFAFAFA),
                            onPressed: () {
                              _currentPage = 2;
                              _getCurrPage();
                            }
                        ),
                        IconButton(
                            icon: SvgPicture.asset('assets/icons/profile.svg'),
                            color: Color(0xFFFAFAFA),
                            onPressed: () {
                              _currentPage = 3;
                              _getCurrPage();
                            }
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}