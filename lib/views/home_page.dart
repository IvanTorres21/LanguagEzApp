import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/notification_controller.dart';
import 'package:languageez_app/widgets/Cards/notification_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePageView> {
  NotificationController _notificationController = NotificationController();

  @override
  void initState() {
    getNotifs();
    super.initState();
  }

  Future<void> getNotifs() async {
    await _notificationController.getNotifications();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 2.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context).news}',
                style: titleStyle.merge(TextStyle(color: Colors.black87)),
              ),
              Divider(
                thickness: 3,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 2.3 + 40),
          child: ListView(children: getNotificationsCard()),
        ),
        Positioned(
          top: 0,
          child: SvgPicture.asset('assets/svg/upper_decor.svg'),
        ),
        Positioned(
            top: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Text(
                '${AppLocalizations.of(context).welcome}',
                style: titleStyle,
              ),
            )),
      ],
    );
  }

  List<Widget> getNotificationsCard() {
    List<Widget> cards = [];
    _notificationController.notifications.forEach((element) {
      cards.add(NotificationCard(element));
    });
    return cards;
  }
}
