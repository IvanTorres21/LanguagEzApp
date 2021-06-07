
import 'package:languageez_app/models/notification.dart';
import 'package:languageez_app/repository/notification_repository.dart' as rep;

class NotificationController {


  List<NotificationModel> notifications = [];

  Future<void> getNotifications() async {
    notifications = await rep.getNotifications();
  }
}