import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class notification {
  bool isNotefied = false;

  void setUp() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void sendNotification(String text) {
    isNotefied
        ? AwesomeNotifications().createNotification(
            content: NotificationContent(
            id: -1,
            channelKey: 'basic_channel',
            title: text,
            body: "The Preyer time has became",
          ))
        : null;
  }
}
