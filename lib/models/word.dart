class Word {
  int id;
  String og_word;
  String pr_word;
  Map<String, dynamic> tr_word;
  int seenState = 0;

  Word();

  Word.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'].runtimeType == String ? int.parse(json['id']) :  json['id'];
    this.og_word = json['og_word'];
    this.pr_word = json['pr_word'];
    this.tr_word = json['tr_word'];
  }

  String toJson() {
    return 'id : ${this.id}, og_word : ${this.og_word}, pr_word : ${this.pr_word}, tr_word : ${this.tr_word}]';
  }
}