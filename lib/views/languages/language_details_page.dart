import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/utility/language_utility.dart';
import 'package:languageez_app/views/dictionary/dictionary_details_page.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_raised_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'lessons/lessons_page.dart';
import 'minigames/minigames_page.dart';

class LanguageDetailsPage extends StatefulWidget {

  int languageId;

  LanguageDetailsPage(this.languageId);

  @override
  State<StatefulWidget> createState() {
    return LanguageDetailsState();
  }
}

class LanguageDetailsState extends State<LanguageDetailsPage> {

  LanguageController _languageController = LanguageController();
  Locale myLocale;


  @override
  void initState() {
    _loadLanguage();
    super.initState();
  }

  _loadLanguage() async {
    await _languageController.receiveLanguage(this.widget.languageId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body: this._languageController.language != null ?
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: MediaQuery.of(context).size.height / 2.3 + 40),
              child: ListView(
                  children: [
                    DynamicButton(
                        () {
                          if(this._languageController.language.assigned)
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LessonsPage(this.widget.languageId)));
                          else
                            _dialog('${AppLocalizations.of(context).need_follow}');
                        },
                      '${AppLocalizations.of(context).lessons}'
                    ),
                    DynamicButton(
                            () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MinigamesPage(this.widget.languageId)));
                        },
                        '${AppLocalizations.of(context).minigames}'
                    ),
                    DynamicButton(
                            () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => DictionaryDetailsPageView(false, this.widget.languageId)));
                        },
                        '${AppLocalizations.of(context).dictionary}'
                    ),
                  ]
              ),
            ),
            Positioned(
              top: 0,
              child: SvgPicture.asset('assets/svg/upper_decor.svg'),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8,
                    right: MediaQuery.of(context).size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 38.0,
                      backgroundImage:
                      NetworkImage(this._languageController.language.image),
                      backgroundColor: Colors.transparent,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                          child: Text(
                            this._languageController.language.name[myLocale.languageCode],
                            style: titleBlackStyle,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A53C2)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            this._languageController.language.assigned ? '${AppLocalizations.of(context).following}' : '${AppLocalizations.of(context).follow}',
                            style: TextStyle(color: Color(0xFFFAFAFA)),
                          ),
                        ),
                        onPressed:  !this._languageController.language.assigned ? () async {
                            await _languageController.tryAssign(this.widget.languageId);
                            setState(() {});
                          } : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFAFAFA), size: 35,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
            ),
          ],
        )
        : Container(),
    );
  }

  /// Makes a dialog box
  Future<void> _dialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oops!'),
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