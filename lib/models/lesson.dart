import 'package:languageez_app/models/exercise.dart';

class Lesson {
  int id;
  Map<String, dynamic> title;
  Map<String, dynamic> theory;
  List<Exercise> exercises = [];

  Lesson();

  Lesson.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.theory = json['theory'];
    List helper = json['exercises'] != null ? json['exercises'] : [];
    print('LESSON');
    helper.forEach((element) {
      this.exercises.add(Exercise.fromJSON(element));
    });
  }
}