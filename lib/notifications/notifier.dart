import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mascotas/exception/notifier_exception.dart';
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
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> requestNotificationsPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleTreatmentNotification({
    required int id,
    required DateTime scheduledDate,
    required String medicine,
    required String dose,
    required String petName,
  }) async {
    try {
      debugPrint(
          "Se va a crear la notificacion a las $scheduledDate con el id $id");
      await scheduleNotification(
        id: id,
        title: 'Notificación de dosis',
        body: 'Es hora de darle $dose miligramos de $medicine a $petName',
        scheduledDate: scheduledDate,
      );
      debugPrint("Se creo la notificacion exitosamente a las $scheduledDate");
    } catch (error) {
      debugPrint('Hubo un error al registrar la notificacion: $error');
      throw NotifierException('Error al registrar la notificacion');
    }
  }

  Future<void> scheduleNotification(
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

  Future<NotificationResponse?> notificationResponse() async {
    NotificationAppLaunchDetails? launchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails != null) {
      return launchDetails.notificationResponse;
    }
    return null;
  }
}
