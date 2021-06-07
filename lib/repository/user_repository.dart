import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:languageez_app/models/user.dart';

FlutterSecureStorage storage = FlutterSecureStorage();
final String loginUrl = 'login';
final String signUpUrl = 'signup';
final String profileUrl = 'get_profile';
final String getFriendsUrl = 'get_friends';
final String addFriendUrl = 'add_friend';
final String deleteFriendUrl = 'delete_friend';

/// Logs in and saves the access token
Future<bool> login(User user) async {
  try {
    // Send the request
    Dio dio = new Dio();
    var res = await dio.post(baseUrl + loginUrl, data: user.toJSON());

    // Receive the request
    if (res.data['status_code'] == 200) {
      // Save the access token, it's the only thing we really need
      await storage.write(key: 'token', value: res.data['access_token']);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

/// Sign up new user
Future<bool> signUp(User user) async {
  try {
    print(user.toJSON());
    // Send the request
    Dio dio = new Dio();
    var res = await dio.post(baseUrl + signUpUrl, data: user.toJSON());

    // Receive the request
    if (res.data['status_code'] == 200) {
      // Save the access token, it's the only thing we really need
      await storage.write(key: 'token', value: res.data['access_token']);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

/// Gets the user profile
Future<User> getProfile() async {
  try {
    // Send the request
    Dio dio = new Dio();
    var res = await dio.post(baseUrl + profileUrl);
    // Receive the request
    if (res.data['status_code'] == 200) {
      User user = User.fromJSON(res.data['user']);
      return user;
    } else {
      return new User();
    }
  } catch (e) {
    print(e.toString());
    return new User();
  }
}

/// Receives the user friends
Future<List<User>> getFriends() async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + getFriendsUrl);

    // Receive the request
    if (res.data['status_code'] == 200) {
      List<User> friends = [];
      List data = res.data['data'];
      data.forEach((friend) {
        friends.add(User.fromJSON(friend));
      });
      return friends;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

/// Add a friend
Future<bool> addFriend(String friendEmail) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    Map<String, dynamic> json = {'email': friendEmail};
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + addFriendUrl, data: json);
    // Receive the request
    if (res.data['status_code'] == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

/// Delete a friend
Future<bool> deleteFriend(int id) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    Map<String, dynamic> json = {'friend_id': id};
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + deleteFriendUrl, data: json);
    // Receive the request
    if (res.data['status_code'] == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
