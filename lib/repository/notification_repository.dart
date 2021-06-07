import 'package:languageez_app/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:languageez_app/models/notification.dart';


String getNotificationsUrl = 'get_notifications';

/// Get all notifications
Future<List<NotificationModel>> getNotifications() async {
  try {
    // Send the request
    Dio dio = new Dio();
    var res = await dio.get(baseUrl + getNotificationsUrl);

    // Receive the request
    if (res.data['status_code'] == 200) {
      // Save the access token, it's the only thing we really need
      List<NotificationModel> notifications = [];
      List content = res.data['notifications'];
      content.forEach((notif) {
        notifications.add(NotificationModel.fromJSON(notif));
      });
      print(notifications);
      return notifications;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}