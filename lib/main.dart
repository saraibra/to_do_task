import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';

import 'application/app.dart';
import 'services/notifications_permission.dart';

Future<void> main() async {
 AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  'resource://drawable/app_icon',
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor:ColorManager.primary,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupkey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: true
);// <----
  runApp(MyApp());
}
