import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createNotification(DateTime date) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 5,
      channelKey: 'basic_channel',
      title: '${Emojis.time_alarm_clock} + You have a task to do',
      wakeUpScreen: true,
      category: NotificationCategory.Reminder
    ),
    schedule: NotificationCalendar.fromDate(date: date,
    allowWhileIdle: true,repeats: true
     ),
     
  );
}
