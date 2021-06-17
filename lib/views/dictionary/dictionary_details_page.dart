
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageez_app/models/word.dart';
import 'package:languageez_app/utility/dictionary_utility.dart';
import 'package:languageez_app/views/dictionary/study_page.dart';
import 'package:languageez_app/widgets/Buttons/blue_button.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DictionaryDetailsPageView extends StatefulWidget {

  bool localDictionary;
  int id;
  String name;

  DictionaryDetailsPageView(this.localDictionary, this.id, {this.name});

  @override
  State<StatefulWidget> createState() {
    return DictionaryDetailsPageState();
  }
}

class DictionaryDetailsPageState extends State<DictionaryDetailsPageView> {

  DictionaryController _dictionaryController = new DictionaryController();
  TextEditingController _filterController = new TextEditingController();
  bool loaded = false;
  Locale myLocale;

  @override
  void initState() {
    this._filterController.addListener(() {
      _dictionaryController.filter(_filterController.text);
      setState(() {});
    });
    super.initState();
  }

  _loadDictionary() async {
    if(this.widget.localDictionary) {
      await _dictionaryController.getDictionaryLocal(this.widget.name);
    } else {
      await _dictionaryController.getDictionaryLanguage(this.widget.id);
    }
    setState(() {});
    loaded = true;
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


  List<Widget> _getWords() {
    List<Widget> widgets = [];
    _dictionaryController.currWords.forEach((element) {
      if(this.widget.localDictionary) {
        widgets.add(
          Dismissible(
            key: Key(element.id.toString()),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextButton(
                child: Text('${element.og_word} - (${element.pr_word})', style: wordBlackStyle,),
                onPressed: () {
                  _dialog(element);
                },
              )
            ),
            background: deleteBackground(),
            onDismissed: (direction) async {
              setState(() {
                _dictionaryController.currWords.remove(element);
                _dictionaryController.dictionary.words.remove(element);
              });
              await _dictionaryController.deleteWord(element, this.widget.name);
            },
          ));
      } else {
        widgets.add(
            TextButton(
              child: Text('${element.og_word} - (${element.pr_word})', style: wordBlackStyle,),
              onPressed: () {
                _dialog(element);
              },
            )
        );
      }
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    if(!loaded) _loadDictionary();
    return Scaffold(
      body: Stack(
        children: [
          (this.widget.localDictionary) ?
          Positioned(
            top: MediaQuery.of(context).size.height / 6,
            right:  MediaQuery.of(context).size.width / 7,
            child: IconButton(
              icon: Icon(Icons.add_circle_outline,  color: Color(0xFF4969F5), size: 55,),
              onPressed: () async {
                await _dialogWord();
              },
            ),
          ) : Container(),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child:  Center(
                child: BlueButton(
                    () {
                      if(_dictionaryController.dictionary.words.isNotEmpty)
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => StudyPage(this._dictionaryController.dictionary.words)));
                    },
                    '${AppLocalizations.of(context).study}'
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).size.height / 2.3 + 40,
            bottom: 70),
            child: ListView(
                children: _getWords()
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 90,
                right: 20,
                top: MediaQuery.of(context).size.height / 3.1 + 40),
            child: InputField(_filterController, '${AppLocalizations.of(context).search}...')
          ),
          Positioned(
            top: 0,
            child: IgnorePointer(
              child: SvgPicture.asset('assets/svg/upper_decor.svg'),
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
      ),
    );
  }


  /// Makes a dialog box
  Future<void> _dialog(Word word) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(word.og_word),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(word.tr_word['0'] != null ? word.tr_word['0'] : word.tr_word[myLocale.languageCode]),
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

  TextEditingController _ogWord = TextEditingController();
  TextEditingController _prWord = TextEditingController();
  TextEditingController _trWord = TextEditingController();

  /// Makes a dialog box to create a word
  Future<void> _dialogWord() async {
    _ogWord.text = '';
    _prWord.text = '';
    _trWord.text = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).new_word}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: InputField(_ogWord, '${AppLocalizations.of(context).og_word}'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: InputField(_prWord, '${AppLocalizations.of(context).pr_word}'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: InputField(_trWord, '${AppLocalizations.of(context).tr_word}'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('${AppLocalizations.of(context).save}'),
              onPressed: () async {
                if(_ogWord.text.isNotEmpty && _prWord.text.isNotEmpty && _trWord.text.isNotEmpty) {
                  Word word = Word();
                  word.tr_word = {'0' : _trWord.text};
                  word.pr_word = _prWord.text;
                  word.og_word = _ogWord.text;
                  await _dictionaryController.saveWord(word, this.widget.name);
                  _loadDictionary();
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