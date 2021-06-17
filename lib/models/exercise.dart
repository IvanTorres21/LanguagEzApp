class Exercise {

  int id;
  int type;
  Map<String, dynamic> sentence;
  Map<String, dynamic> translation;
  Map<String, dynamic> og_word;
  Map<String, dynamic> correct_word;
  Map<String, dynamic> wrong_word;

  Exercise();

  Exercise.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.type = json['type'];
    this.sentence = json['sentence'];
    this.translation = json['translation'];
    this.og_word = json['og_word'];
    this.correct_word = json['correct_word'];
    this.wrong_word = json['wrong_word'];
    print('EXERCISE');
  }
}