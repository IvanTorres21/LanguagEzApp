import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/views/profile/friends/user_profile_page.dart';

class FriendCard extends StatelessWidget {

  User user;

  FriendCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  user.username,
                  style: titleBlackStyle,
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserProfilePage(this.user))
                );
              },
            )
          ],
        ),
        Divider(
          thickness: 2,
          color: Theme.of(context).shadowColor,
        )
      ],
    );
  }
}