import 'dart:convert';

class Badge {
  int id;
  Map<String, String> title;
  Map<String, String> description;
  bool assigned;

  Badge.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = Map.from(jsonDecode(json['name']));
    this.description = Map.from(jsonDecode(json['description']));
    this.assigned = json['unlocked'];
  }
}