import 'package:languageez_app/models/language.dart';
import 'package:languageez_app/repository/lesson_repository.dart';


class LessonController {

  Language language;

  /// Receives all lessons
  receiveLessons(int languageId) async {
    language = await getLessons(languageId);
  }

  /// Marks a lesson as done
  tryMarkLessonAsDone(int id) async {
    bool marked = await markLessonAsDone(id);
  }

  /// Separates words from a string into a list<String>
  List<String> separateWord(String wordList) {
    List<String> words = [];
    words = wordList.split(',');
    return words;
  }
}