
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/utility/dictionary_utility.dart';
import 'package:languageez_app/views/dictionary/dictionary_details_page.dart';
import 'package:languageez_app/widgets/Buttons/dictionary_raised_button.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_raised_button.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DictionaryPageView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return DictionaryPageState();
  }
}

class DictionaryPageState extends State<DictionaryPageView> {

  TextEditingController _languageName = TextEditingController();
  DictionaryController _dictionaryController = DictionaryController();
  List<String> dictionaries = [];
  Locale myLocale;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  _loadDictionaries() async {
    dictionaries = await _dictionaryController.loadDictionariesLocal();
    setState(() {});
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    if(!loaded) _loadDictionaries();
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 6,
          right:  MediaQuery.of(context).size.width / 7,
          child: IconButton(
            icon: Icon(Icons.add_circle_outline,  color: Color(0xFF4969F5), size: 55,),
            onPressed: () async {
              await _dialog();
            },
          ),
        ),
        Positioned(
          top: 0,
          child: IgnorePointer(
            child:  SvgPicture.asset('assets/svg/upper_decor.svg'),
          ),
        ),
        Positioned(
            top: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Text(
                '${AppLocalizations.of(context).dictionary}',
                style: titleStyle,
              ),
            )
        ),
       Padding(
         padding: EdgeInsets.only(
             top: MediaQuery.of(context).size.height / 2.3,
             bottom: 50),
         child:  ListView(
           children: getDictionaryCard(),
         ),
       )
      ],
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

  /// Gets the dictionary cards
  List<Widget> getDictionaryCard(){
    List<Widget> cards = [];
    dictionaries.forEach((element) {
      cards.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Dismissible(
            key: Key(element),
            child: Container(

              width: MediaQuery.of(context).size.width / 1.2,
              child:  DictionaryButton(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DictionaryDetailsPageView(true, 0, name: element,)));
              }, element),
            ),
            background: deleteBackground(),
            onDismissed: (direction) async {
              setState(() {
                dictionaries.remove(element);
              });
              await _dictionaryController.deleteDic(element);
            },
          )
        )
      );
    });
    return cards;
  }

  /// Makes a dialog box
  Future<void> _dialog() async {
    _languageName.text = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).new_dictionary}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InputField(_languageName, '${AppLocalizations.of(context).name}')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('${AppLocalizations.of(context).save}'),
              onPressed: () async {
                if(_languageName.text.isNotEmpty) {
                  await _dictionaryController.saveDictionary(_languageName.text);
                  _loadDictionaries();
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