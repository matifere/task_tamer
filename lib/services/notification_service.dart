import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings
    );
    
    await Permission.notification.request();
  }

  Future<void> showTimerNotification(String taskTitle, DateTime startTime) async {
    final int when = startTime.millisecondsSinceEpoch;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'active_task_channel',
      'Active Task',
      channelDescription: 'Muestra el tiempo transcurrido de la tarea activa',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true, 
      autoCancel: false,
      usesChronometer: true,
      when: when,
      showWhen: true,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Tarea en curso',
      taskTitle,
      platformChannelSpecifics,
    );
  }

  Future<void> showPausedNotification(String taskTitle, String formattedTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'active_task_channel',
      'Active Task',
      channelDescription: 'Muestra el tiempo transcurrido de la tarea activa',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      autoCancel: false,
      usesChronometer: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Tarea pausada',
      '$taskTitle ($formattedTime)',
      platformChannelSpecifics,
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }
}
