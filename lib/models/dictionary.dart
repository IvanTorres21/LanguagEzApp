import 'package:languageez_app/models/word.dart';

class Dictionary {

  int id;
  String name;
  List<Word> words = [];

  Dictionary();

  Dictionary.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'] != null ? json['id'] : 0;
    this.name = json['name'] != null ? json['name'] : '';
    List aux = json['dictionary'] != null ? json['dictionary'] : [];
    aux.forEach((element) {
      this.words.add(Word.fromJSON(element));
    });
  }

  Map<String, dynamic> toJson() {
    List wordsJson = [];
    words.forEach((element) {
      wordsJson.add(element.toJson());
    });
    return {
      "id" : this.id,
      "name" : this.name,
      "words" : wordsJson
    };
  }
}