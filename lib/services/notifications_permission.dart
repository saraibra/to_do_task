import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/string_manager.dart';

class NotificationsPermission{
  void init(BuildContext context)  {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(AppStrings.allowNotifications),
                content: const Text(AppStrings.sendNotifications),
                actions: [
                  TextButton(
                      onPressed: () {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: const Text(AppStrings.dontAllow)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppStrings.allow)),
                ],
              );
            });
      }
    });
  }
}
