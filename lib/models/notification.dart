class NotificationModel {
  Map<String, dynamic> message;
  String date;

  NotificationModel.fromJSON(Map<String, dynamic> json) {
    message = json['content'];
    date = formatDate(json['created_at']);
  }

  String formatDate(String date) {
    return (date.substring(8, 10) + '/' + date.substring(5, 7));
  }
}