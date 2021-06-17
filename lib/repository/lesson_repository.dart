
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/constants/urls.dart';
import 'package:languageez_app/models/language.dart';
import 'package:languageez_app/utility/badge_utility.dart';

FlutterSecureStorage storage = new FlutterSecureStorage();

String lessons = 'get_lessons';
String mark_lesson = 'mark_lesson';

BadgeController _badgeController = BadgeController();

Future<Language> getLessons(int languageId) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + lessons, data: {"id" : languageId});
    res.data = res.data;
    // Receive the request
    if (res.statusCode == 200) {
      Language language= Language.fromJSON(res.data);
      return language;
    } else {
      return Language();
    }
  } catch (e) {
    print(e.toString());
    return Language();
  }
}

Future<bool> markLessonAsDone(int id) async {
  try {
    Dio dio = new Dio();
    String token = await storage.read(key: 'token');
    dio.options.headers['Authorization'] = "Bearer " + token;
    var res = await dio.post(baseUrl + mark_lesson, data: {'id' : id});
    // Receive the request
    if (res.data['status_code'] == 200) {
      int lessonsDone = 0;
      if(await storage.containsKey(key: 'lessonsTotal'))
        lessonsDone = int.parse(await storage.read(key: 'lessonsTotal'));
      lessonsDone++;
      await storage.write(key: 'lessonsTotal', value: lessonsDone.toString());
      _badgeController.checkLessonsBadge(lessonsDone);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}
