import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Local_Notification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
static final onClickNotification = BehaviorSubject<String>() ;

static void onNotificationTap(NotificationResponse notificationResponse){
  onClickNotification.add(notificationResponse.payload!);
}
static Future<void> init() async {
  // Initialize the local notifications plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Set valid Android icon
  final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: ((id, title, body, payload) => null),
    );
  final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, // Provide valid Android settings
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationTap,
    onDidReceiveBackgroundNotificationResponse: onNotificationTap,
  );
}

static String getTimeOnly(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

static Future<void> showScheduledNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledNotificationDateTime,
  String? payload,
}) async {
  // Convert DateTime to TZDateTime
  tz.initializeTimeZones();
  
  // Extract only the time from scheduledNotificationDateTime
  String timeOnly = getTimeOnly(scheduledNotificationDateTime);
  print('Scheduled time: $timeOnly');

  // Get today's date

  
  // Create a new DateTime object with today's date and the extracted time
 DateTime now = DateTime.now();
DateTime scheduledTimeToday = DateTime(
  now.year,
  now.month,
  now.day,
  scheduledNotificationDateTime.hour,
  scheduledNotificationDateTime.minute,
);
print('schedulded notification : $scheduledTimeToday '  );
  // Define notification details
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'repeating channel id',
    'repeating channel name',
    channelDescription: 'repeating description',
    priority: Priority.high,
    importance: Importance.max,
  );
  
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  // Schedule the notification using the new DateTime object
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledTimeToday, tz.local),
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

}
