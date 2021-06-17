import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:languageez_app/constants/text_styles.dart';
import 'package:languageez_app/models/word.dart';
import 'package:languageez_app/widgets/Buttons/blue_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudyPage extends StatefulWidget {

  List<Word> words = [];

  StudyPage(this.words);

  @override
  State<StatefulWidget> createState() {
    return StudyPageState();
  }
}

class StudyPageState extends State<StudyPage> {

  int currWord = 0;
  int correctWords = 0;
  bool finished = false;
  List<Word> wordsList = [];
  Locale myLocale;

  @override
  void initState() {
    wordsList = this.widget.words;
    wordsList.forEach((element) {
      element.seenState = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myLocale = Localizations.localeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 00,
            child: SvgPicture.asset('assets/svg/lower_decor.svg'),
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
         (!finished) ?
         Padding(
           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
           child:  Column(
             children: [
               Padding(
                 child: Text('${currWord+1}/${wordsList.length}'),
                 padding: EdgeInsets.only(bottom: 10),
               ),
               Row(
                 children: [
                   Padding(
                     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                     child: IconButton(
                       icon: Icon(Icons.arrow_back_ios, color: (currWord > 0) ? Color(0xFF4969F5) : Color(0x004969F5), size: 35,),
                       onPressed: () {
                         if(currWord > 0) {
                           currWord--;
                           setState(() {});
                         }
                       },
                     ),
                   ),
                   GestureDetector(
                     child:  Container(
                       width: MediaQuery.of(context).size.width / 1.55,
                       height: MediaQuery.of(context).size.height / 3,
                       decoration: BoxDecoration(
                           color: wordsList[currWord].seenState == 0 ? Color(0xFFFAFAFA) :
                           wordsList[currWord].seenState == 1 ? Color(0xFF4969F5) : Color(0xFF96FF85),
                           boxShadow: [
                             new BoxShadow(
                               offset: Offset.fromDirection(1),
                               color: Theme.of(context).shadowColor,
                               spreadRadius: 1.0,
                               blurRadius: 1.0,
                             ),
                           ],
                           borderRadius: BorderRadius.circular(20)
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           (wordsList[currWord].seenState > 0) ?
                           Text('${(wordsList[currWord].tr_word['0'] != null ? wordsList[currWord].tr_word['0'] : wordsList[currWord].tr_word[myLocale.languageCode])}', style: titleBlackStyle,)
                               :
                           Text('${wordsList[currWord].og_word}', style: titleBlackStyle,)
                         ],
                       ),
                     ),
                     onTap: () {
                       wordsList[currWord].seenState = 1;
                       setState(() {});
                     },
                   ),
                   Padding(
                     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                     child: IconButton(
                       icon: Icon(Icons.arrow_forward_ios, color: (currWord < wordsList.length) ? Color(0xFF4969F5) : Color(0x004969F5), size: 35,),
                       onPressed: () {
                         if(currWord < wordsList.length-1) {
                           currWord++;
                           setState(() {});
                         } else {
                           finished = true;
                           setState(() {});
                         }
                       },
                     ),
                   )
                 ],
               ),
               (wordsList[currWord].seenState == 1) ?
               BlueButton(() {
                    wordsList[currWord].seenState = 2;
                    correctWords++;
                    setState(() {});
                  }
                  , '${AppLocalizations.of(context).got_it}'
               )
                   : Container()
             ],
           )
         ) :
         Padding(
             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
             child:  Column(
               children: [
                 Padding(
                   child: Text('${AppLocalizations.of(context).you_got} $correctWords/${wordsList.length}\n${AppLocalizations.of(context).congrats}!', style: wordBlackStyle,),
                   padding: EdgeInsets.only(bottom: 100),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     BlueButton(() {
                       Navigator.pop(context);
                     }
                         , '${AppLocalizations.of(context).go_back}'
                     )
                   ],
                 )
              ]
             )
         ),
          Positioned(
              top: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4969F5), size: 35,),
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

}