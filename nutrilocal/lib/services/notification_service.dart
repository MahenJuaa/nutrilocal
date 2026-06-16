import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void>
      initialize() async {

    const AndroidInitializationSettings
        androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
        initializationSettings =
        InitializationSettings(
      android:
          androidSettings,
    );

    await notificationsPlugin
        .initialize(
      initializationSettings,
    );
  }

  static Future<void>
      showNotification({

    required String title,

    required String body,

  }) async {

    const AndroidNotificationDetails
        androidDetails =
        AndroidNotificationDetails(

      'nutrilocal_channel',

      'NutriLocal Notifications',

      importance:
          Importance.max,

      priority:
          Priority.high,
    );

    const NotificationDetails
        notificationDetails =
        NotificationDetails(
      android:
          androidDetails,
    );

    await notificationsPlugin.show(

      0,

      title,

      body,

      notificationDetails,
    );
  }
}