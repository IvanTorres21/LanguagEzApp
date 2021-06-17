import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/models/language.dart';
import 'package:languageez_app/views/languages/language_details_page.dart';

class LanguageCard extends StatelessWidget {

   Language language;
   Locale myLocale;

   LanguageCard(this.language);

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                  NetworkImage(this.language != null ? this.language.image : ''),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  language.name[myLocale.languageCode],
                  style: titleBlackStyle,
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LanguageDetailsPage(this.language.id))
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