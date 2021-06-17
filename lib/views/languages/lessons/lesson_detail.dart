import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languageez_app/constants/card_styles.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/models/lesson.dart';
import 'package:languageez_app/utility/lesson_utility.dart';
import 'package:languageez_app/widgets/Buttons/blue_button.dart';
import 'package:languageez_app/widgets/TextFields/InputField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LessonDetailsPage extends StatefulWidget {

  Lesson lesson;
  bool done;


  LessonDetailsPage(this.lesson, this.done);

  @override
  State<StatefulWidget> createState() {
    return LessonDetailsState();
  }
}

class LessonDetailsState extends State<LessonDetailsPage> {

  bool theory = true;
  int currExercise = 0;
  TextEditingController _controller = TextEditingController();
  bool nextExercise = false; // false if we want to check the exercise or true if we want to go the next one
  bool correct = false;
  String userOption = ''; //Here we store either the word or full translation
  Widget actExercise = Container();
  LessonController _lessonController = new LessonController();
  Locale myLocale;
  bool firstLoad = false;

  @override
  void initState() {

    _controller.addListener(() {
      userOption = _controller.text;
    });
    super.initState();
  }

  /// Change the actual exercise the user is doing, need to do it from here to
  /// avoid problems with current state and context.
  _changeExercise() {
    userOption = '';
    if(this.widget.lesson.exercises[currExercise].type == 1) { // Words
      actExercise = ListView(
        children: _getExerciseWords(),
      );
    } else { // Sentence translation
      actExercise = ListView(
        children: _getSentenceWords(),
      );
    }
    setState(() {});
    firstLoad = true;
  }

  /// Prepares the exercise with the sentence
  List<Widget> _getSentenceWords() {
    List<Widget> widgets = [];
    // Get the original sentence
    widgets.add(
        Center(
          child: Text(this.widget.lesson.exercises[currExercise].sentence[myLocale.languageCode], style: exerciseStyle,),
        )
    );
    widgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: InputField(_controller, '${AppLocalizations.of(context).answer}'),
      )
    );
    return widgets;
  }

  /// Prepares the exercise with the list of words of the exercise
  List<Widget> _getExerciseWords() {
    List<Widget> widgets = [];
    // Get the original word
    widgets.add(
      Center(
        child: Text(this.widget.lesson.exercises[currExercise].og_word[myLocale.languageCode], style: exerciseStyle),
      )
    );
    // Get all the words
    List<String> words = _lessonController.separateWord(this.widget.lesson.exercises[currExercise].wrong_word[myLocale.languageCode]);
    words.add(this.widget.lesson.exercises[currExercise].correct_word[myLocale.languageCode]);
    words.shuffle();
    widgets.add(
     StatefulBuilder(
       builder: (context, setState) {
         List<Widget> aux = [];
         words.forEach((word) {
           aux.add(
               GestureDetector(
                 child: Padding(
                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                   child: Container(
                     decoration: userOption.compareTo(word) == 0 ? wordCard.copyWith(color:  Color(0xFF4969F5)) : wordCard,
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                       child: Text(word),
                     ),
                   ),
                 ),
                 onTap: () {
                   userOption = word;
                   print('clicked on $word userOption : ${userOption.compareTo(word)}');
                   setState(() {});
                 },
               )
           );
         });
         return Padding(
           padding: EdgeInsets.only(top: 30, left: 10, right: 10),
           child:  Wrap(
             alignment: WrapAlignment.center,
             spacing: 10,
             children: aux,
           ),
         );
       },
     )
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
   if(!firstLoad) _changeExercise();
    return Scaffold(
      body: this.widget.lesson != null ?
      Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150, bottom: 10, left: 10, right: 10),
            child: actExercise
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child:  Center(
                child: Column(
                  children: [
                    (this.widget.lesson.exercises[currExercise].type == 1) ?
                    Text(
                      '*${AppLocalizations.of(context).select_meaning}*',
                      style: hintStyle,
                    ) :
                    Text(
                      '*${AppLocalizations.of(context).translate_sentence}*',
                      style: hintStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlueButton(
                            () async {
                          if(nextExercise) {
                            if(this.currExercise < this.widget.lesson.exercises.length -1) {
                              // Next exercise
                              currExercise++;
                              _controller.text = '';
                              _changeExercise();
                            } else {
                              // Complete lesson
                              if(!(this.widget.done)) {
                                await this._lessonController.tryMarkLessonAsDone(this.widget.lesson.id);
                              }
                              Navigator.pop(context);
                            }
                            nextExercise = false;
                            setState(() {});
                          } else {
                            if(this.userOption.isNotEmpty) {
                              if(this.widget.lesson.exercises[currExercise].type == 1) { // Word
                                print('${userOption} - ${this.widget.lesson.exercises[currExercise].correct_word[myLocale.languageCode]}');
                                if(this.userOption.compareTo(this.widget.lesson.exercises[currExercise].correct_word[myLocale.languageCode]) == 0) {
                                  correct = true;
                                } else {
                                  correct = false;
                                }
                              } else { // Sentence
                                print('${userOption} - ${this.widget.lesson.exercises[currExercise].translation[myLocale.languageCode]}');
                                List<String> correctAnswers = [];
                                correctAnswers = _lessonController.separateWord(this.widget.lesson.exercises[currExercise].translation[myLocale.languageCode]);
                                if(correctAnswers.contains(userOption)) {
                                  correct = true;
                                } else {
                                  correct = false;
                                }

                              }
                              nextExercise = true;
                            } else {
                              _dialog('${AppLocalizations.of(context).answer_empty}');
                            }
                            setState(() {});
                          }
                        },
                        (nextExercise) ? '${AppLocalizations.of(context).next}' : '${AppLocalizations.of(context).check}'
                    ),
                  ],
                )
            ),
          ),
          (nextExercise) ?
          Positioned(
            bottom: MediaQuery.of(context).size.height / 4,
            right: 0,
            left: 0,
            child: (correct) ?
                Column(
                  children: [
                    Text('${AppLocalizations.of(context).correct}', style: correctStyle )
                  ],
                )
                : Column(
              children: [
                Text('${AppLocalizations.of(context).incorrect}', style: incorrectStyle,),
                (this.widget.lesson.exercises[currExercise].type == 1) ?
                Text('${AppLocalizations.of(context).correct_answer} ${this.widget.lesson.exercises[currExercise].correct_word[myLocale.languageCode]}')
                    :
                Text('${AppLocalizations.of(context).correct_answer} ${this.widget.lesson.exercises[currExercise].translation[myLocale.languageCode]}')
              ],
            ),
          ) :
          Container(),
          Positioned(
            top: 0,
            child: IgnorePointer(
              child:  SvgPicture.asset('assets/svg/upper2_decor.svg'),
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
          (theory) ?
          Container(
            color: Color(0x99222222),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
          : Container(),
          (theory) ?
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
              ),
              Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Theme.of(context).backgroundColor,
                ),
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Html(
                        data: this.widget.lesson.theory[myLocale.languageCode],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child:  BlueButton(
                             () {
                           theory = false;
                           setState(() {});
                         },
                         '${AppLocalizations.of(context).next}'
                     ),
                   )
                  ],
                ),
              ),
            ],
          )
          : Container(),
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
          title: Text('${AppLocalizations.of(context).error}'),
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