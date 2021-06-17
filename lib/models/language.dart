import 'package:languageez_app/models/lesson.dart';

class Language {

  int id;
  Map<String, dynamic> name;
  String image;
  bool assigned;
  int lessonsDone = 0;
  List<Lesson> lessons = [];

  Language();

  Language.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
    this.assigned = json['assigned'];
    this.lessonsDone = json['lessons_done'] != null ? json['lessons_done'] : 0;
    List helper =  json['lessons'] != null ? json['lessons'] : [];
    print('LANGUAGE');
    helper.forEach((element) {
      this.lessons.add(Lesson.fromJSON(element));
    });

  }
}