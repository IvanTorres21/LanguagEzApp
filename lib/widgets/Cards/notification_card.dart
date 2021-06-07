import 'package:flutter/material.dart';
import 'package:languageez_app/models/notification.dart';

class NotificationCard extends StatelessWidget {

  NotificationModel _notification ;


  NotificationCard(this._notification);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
            boxShadow:  [
              new BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 1.0,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
                _notification.date + ' - ' +_notification.message['en']
            ),
          )
      ),
    );
  }

}