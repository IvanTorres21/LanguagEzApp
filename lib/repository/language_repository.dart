
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/constants/urls.dart';
import 'package:languageez_app/models/dictionary.dart';
import 'package:languageez_app/models/language.dart';
import 'package:languageez_app/utility/badge_utility.dart';

FlutterSecureStorage storage = new FlutterSecureStorage();
BadgeController _badgeController = BadgeController();

String languages = 'languages';
String language = 'get_language/';
String assign = 'assign_language';
String dictionary = 'dictionary';

/// Receives all languages from the DB
Future<List<Language>> getLanguages() async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.get(baseUrl + languages);

    // Receive the request
    if (res.data['status_code'] == 200) {
      List<Language> languages = [];
      List data = res.data['languages'];
      data.forEach((language) {
        languages.add(Language.fromJSON(language));
      });

      return languages;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

/// Gets data from a specific language
Future<Language> getLanguage(int id) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.get(baseUrl + language + id.toString());

    // Receive the request
    if (res.data['status_code'] == 200) {
      return Language.fromJSON(res.data['language']);
    } else {
      return new Language();
    }
  } catch (e) {
    print(e.toString());
    return new Language();
  }
}

/// Assigns the language to the user
Future<bool> assignLanguage(int id) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + assign, data: {"id" : id});
    // Receive the request
    if (res.data['status_code'] == 200) {
      int numberFollowed = 0;
      if(await storage.containsKey(key: 'languagesFollowed'))
        numberFollowed = int.parse(await storage.read(key: 'languagesFollowed'));
      numberFollowed++;
      await storage.write(key: 'languagesFollowed', value: numberFollowed.toString());
      _badgeController.checkLanguageBadge(numberFollowed);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<Dictionary> getDictionary(int languageId) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + dictionary, data: {"id" : languageId});
    // Receive the request
    if (res.data['status_code'] == 200) {
      print(res.data);
      return Dictionary.fromJSON(res.data);
    } else {
      return Dictionary();
    }
  } catch (e) {
    print(e.toString());
    return Dictionary();
  }
}
