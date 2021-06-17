
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/models/user.dart';
import 'package:languageez_app/repository/user_repository.dart' as rep;

class UserController {

  FlutterSecureStorage storage = FlutterSecureStorage();
  List<User> friends = [];
  User user;

  /// Manages login
  Future<bool> login(User user) async {
    bool loggedIn = false;
    if(user.email.isNotEmpty && user.password.isNotEmpty)
      loggedIn= await rep.login(user);
    return loggedIn;
  }

  /// Checks if the user has logged in before
  Future<bool> autoLogin() async {
    try {
      if(await storage.read(key: 'token') != null)
        return true;
      return false;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  /// Logs out the user
  Future<bool> logOut() async {
    try {
      storage.write(key: 'token', value: null);
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  /// Signs up the user
  Future<bool> signUp(User user) async {
    try {
      bool signedUp = false;
      if(user.email.isNotEmpty && user.password.isNotEmpty && user.username.isNotEmpty)
        signedUp = await rep.signUp(user);
      return signedUp;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> loadProfile() async {
    user = await rep.getProfile();
  }

  /// Add friend
  Future<bool> addFriend(String email) async {
    try {
      bool addedFriend = false;
      if(email.isNotEmpty)
        addedFriend = await rep.addFriend(email);
      return addedFriend;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  /// Get friends
   Future<void> getFriends() async {
     friends = await rep.getFriends();
  }

  /// Delete friend
  Future<void> deleteFriend(int id) async {
    await rep.deleteFriend(id);
  }

  Future<void> changeLocale(String locale) async {
    await storage.write(key: 'locale', value: locale);
  }
}