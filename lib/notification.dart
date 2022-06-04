import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodorot/main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


class NotificationAPI {
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();


  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await notifications.initialize(settings, onSelectNotification: (payload) async {});

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification ({
  int id =0,
    String? title,
    String? body,
    String? payload,
}) async =>
      notifications.show(id, title, body, await notificationDetails(), payload: payload);

  static Future showScheduledNotification ({
    int id =0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate
  }) async =>
      notifications.zonedSchedule(id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await notificationDetails(),
          payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}