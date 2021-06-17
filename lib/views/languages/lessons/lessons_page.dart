import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/utility/lesson_utility.dart';
import 'package:languageez_app/views/languages/lessons/lesson_detail.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_color_raised_button.dart';
import 'package:languageez_app/widgets/Buttons/dynamic_raised_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LessonsPage extends StatefulWidget {

  int id;

  LessonsPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return LessonsPageState();
  }
}

class LessonsPageState extends State<LessonsPage> {

  LessonController _lessonController = LessonController();
  Locale myLocale;

  @override
  void initState() {
    loadLessons();
    super.initState();
  }

  void loadLessons() async {
    await _lessonController.receiveLessons(this.widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body: this._lessonController.language != null ?
      Stack(
        children: [

          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).size.height / 2.3 + 40),
            child: ListView(
                children: this._lessonController.language.id != null ? getLessonsCard()
                 : [
                   Center(
                     child: Text(
                         '${AppLocalizations.of(context).went_wrong}'
                     ),
                   )
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
                  SvgPicture.asset(
                    'assets/icons/graduation-hat.svg',
                    width: 70,
                    color: Theme.of(context).accentColor,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Text(
                          '${AppLocalizations.of(context).lessons}',
                          style: titleBlackStyle,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                     '${this._lessonController.language.lessonsDone} / ${this._lessonController.language.lessons.length}',
                      style: lessonCounterStyle,
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

  List<Widget> getLessonsCard() {
    List<Widget> cards = [];
    int currLesson = 1;
    _lessonController.language.lessons.forEach((element) {
      print(currLesson <= this._lessonController.language.lessonsDone);
      cards.add(DynamicColorButton(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => LessonDetailsPage(element, currLesson <= this._lessonController.language.lessonsDone)));
      }, '${element.title[myLocale.languageCode]}', (currLesson <= this._lessonController.language.lessonsDone) ? Color(0xFF96FF85) : Theme.of(context).backgroundColor));
      currLesson++;
    });
    return cards;
  }
  
}