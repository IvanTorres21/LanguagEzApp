
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/language_utility.dart';
import 'package:languageez_app/utility/user_controller.dart';
import 'package:languageez_app/widgets/Cards/friend_card.dart';
import 'package:languageez_app/widgets/Cards/language_card.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendPageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return FriendsPageState();
  }
}

class FriendsPageState extends State<FriendPageView> {

  UserController _userController = UserController();
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _getFriends();
    super.initState();
  }

  _getFriends() async {
    await _userController.getFriends();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Positioned(
            top: 40,
            right: 40,
            child: IconButton(
              icon: Icon(Icons.add_circle_outline,  color: Color(0xFF4969F5), size: 55,),
              onPressed: () async {
                await _dialog();
              },
            ),
          ),
          Positioned(
            top: 50,
            left:  20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,  color: Color(0xFF4969F5), size: 35,),
              onPressed: ()  {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, top: 100, right: 30),
            child: ListView(
              children: getFriendsCards(),
            ),
          ),
          Positioned(
            bottom: 00,
            child: SvgPicture.asset('assets/svg/lower_decor.svg'),
          ),
          Positioned(
              bottom: 20,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  '${AppLocalizations.of(context).my_friends}',
                  style: titleStyle,
                ),
              )
          ),

        ],
      ),
    );
  }

  /// background of slider
  Widget deleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Color(0xFFFFA0A0),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  List<Widget> getFriendsCards() {
    List<Widget> cards = [];
    _userController.friends.forEach((element) {
      cards.add(
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Dismissible(
              key: Key(element.id.toString()),
              child: Container(

                  width: MediaQuery.of(context).size.width / 1.2,
                  child:  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: FriendCard(element),
                  )
              ),
              background: deleteBackground(),
              onDismissed: (direction) async {
                setState(() {
                  _userController.friends.remove(element);
                });
                await _userController.deleteFriend(element.id);
              },
            )
          )
      );
    });
    return cards;
  }


  /// Makes a dialog box
  Future<void> _dialog() async {
    _editingController.text = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).add_friend}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InputField(_editingController, 'Email')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('${AppLocalizations.of(context).save}'),
              onPressed: () async {
                if(_editingController.text.isNotEmpty) {
                  await _userController.addFriend(_editingController.text);
                  _getFriends();
                  setState(() {});
                  Navigator.pop(context);
                }
              },
            ),
            TextButton(
              child: Text('${AppLocalizations.of(context).cancel}'),
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