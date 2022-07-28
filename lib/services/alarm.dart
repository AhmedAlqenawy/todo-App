import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TaskNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  MethodChannel platform =
      const MethodChannel('dexterx.dev/flutter_local_notifications_example');

  init() {
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = const IOSInitializationSettings();
    var setting = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(setting);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> ScheduledTaskNotification(title, date, id, period,TimeOfDay time,String dueTime) async {
    _configureLocalTimeZone();
    init();

    print(dueTime);
    int? numsStr = int.tryParse(dueTime.replaceAll(RegExp(r'[^0-9]'),''));
    print(numsStr);
    DateTime dateTime = DateTime.parse(date);
    dateTime=  dateTime.add(Duration(hours: time.hour,minutes: time.minute));
    print(dateTime);
    dateTime= dateTime.subtract(Duration(minutes: numsStr??0));
    print(dateTime);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      channelDescription: 'repeating description',
      tag: "tag $title",
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    for (int i = 0; i < 3650; i++) {
      if (period == "Daily") {
        dateTime.add(Duration(days: i));
      } else if (period == "Weekly") {
        dateTime.add(Duration(days: i * 7));
      } else if (period == "Monthly") {
        dateTime = DateTime(dateTime.year, dateTime.month + i, dateTime.day);
      } else if (period == "Yearly") {
        dateTime = DateTime(dateTime.year + i, dateTime.month, dateTime.day);
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          "you have to do this task",
          tz.TZDateTime(
              tz.local, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> cancelNotificationWithId(int id) async {
    init();
    await flutterLocalNotificationsPlugin.cancel(id, tag: "tag$id");
  }

}
