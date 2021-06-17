import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:languageez_app/models/badge.dart';
import 'package:languageez_app/repository/user_repository.dart' as rep;

class BadgeController {

  Future<List<Badge>> getBadges() async {
    return await rep.getBadges();
  }

  Future<List<Badge>> getFriendsBadges(int id) async {
    return await rep.getFriendBadges(id);
  }

  /// Assigns badges based on the amount of lessons done
  checkLessonsBadge(int numberDone) async {
    if(numberDone == 1) {
      await rep.assignBadge(4); // 1 lesson done badge
    } else if(numberDone == 5) {
      await rep.assignBadge(5); // 5 lessons done badge
    }
  }

  /// Checks how many languages has been followed
  checkLanguageBadge(int numberFollowed) async{
    if(numberFollowed == 1) {
      await rep.assignBadge(3);
    } else if (numberFollowed == 2) {
      await rep.assignBadge(2);
    }
  }

  /// Checks how many dictionaries have been created
  checkDictionaryCreated(int numberCreated) async {
    if(numberCreated == 1) {
      await rep.assignBadge(1);
    } else if (numberCreated == 5) {
      await rep.assignBadge(6);
    }
  }
}