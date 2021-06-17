
class User {

  int id;
  String username;
  String email;
  String password;
  int level;
  int exp; //Experience if it isn't clear

  User() {
    this.id = 0;
    this.username = '';
    this.email = '';
    this.level = 0;
    this.exp = 0;
  }

  /// Recibe un usuario en formato JSON y crea una instancia
  User.fromJSON(Map<String, dynamic> json) {
    try {
      this.id = json['id'] != null ? json['id'] : 0;
      this.username = json['name'] != null ? json['name'] : 0;
      this.email = json['email'] != null ? json['email'] : 0;
      this.level = json['level'] != null ? json['level'] : 0;
      this.exp = json['points'] != null ? json['points'] : 0;
    } catch(error) {
      print(error.toString());
      this.id = 0;
      this.username = "";
      this.email = "";
      this.level = 0;
      this.exp = 0;
    }
  }

  /// Pasa a formato JSON el usuario
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {};
    json['id'] = this.id;
    json['name'] = this.username;
    json['email'] = this.email;
    json['password'] = this.password;
    return json;
  }
}