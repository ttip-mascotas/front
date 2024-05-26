import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifier {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final String channelId = 'schedule notification';
  final String channelName = 'dose notification';

  Notifier(String currentTimeZone) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> requestNotificationsPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void scheduleTreatmentNotification({
    required int id,
    required DateTime scheduledDate,
    required String medicine,
    required String dose,
  }) {
    scheduleNotification(
      id: id,
      title: 'Notificación de dosis',
      body: 'Es hora de darle el medicamento: $medicine con la dosis: $dose',
      scheduledDate: scheduledDate,
    );
  }

  void scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime scheduledDate}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
          android: AndroidNotificationDetails(
        channelId,
        channelName,
      )),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
