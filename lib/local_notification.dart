import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_reminder/Model/model.dart';
import 'package:medicine_reminder/dbHelper/dbhelper.dart';
import 'package:medicine_reminder/main.dart';
import 'package:medicine_reminder/medstaken.dart';

class LocalNotification {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic Notification',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          defaultColor: Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          onlyAlertOnce: true,
          playSound: true,
          enableVibration: true,
          criticalAlerts: true,
          enableLights: true,
          vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'high_importance_channel_group',
            channelGroupName: 'Group 1')
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print('Notification created');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print('Notification displayed');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print('Notification dismissed');
  }

 static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction) async {
  print('Notification action received');

  final payload = receivedAction.payload ?? {};
  if (payload['navigate'] == 'true') {
    print('Navigate to the page');
    String keys = payload['keys'] ?? ''; // Get the keys from the payload
    MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => medsNotification(keys: keys)));
  }
}


  static Future<void> showNotification({
    required final int id,
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final DateTime? time,
  }) async {
    if (time != null) {
      // Fetch medicines at the time of the notification
      await fetchMedicines();

      // Create the notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'high_importance_channel',
          title: title,
          body: body,
          summary: summary,
          actionType: actionType,
          notificationLayout: notificationLayout,
          category: category,
          bigPicture: bigPicture,
          payload: payload,
        ),
        actionButtons: actionButtons,
        schedule: NotificationCalendar.fromDate(date: time),
      );
    }
  }

  static Future<void> cancelNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }

  static Future<void> fetchMedicines() async {
    List<Medicine> allMedicines = await DatabaseHelper.fetchMedicines();
    List<Medicine> medicines = [];
    //fetch all medicines total dose
    medicines = allMedicines.toList();
    //now filter the medicines based on start date and end date
    DateTime now = DateTime.now();
    medicines = medicines
        .where((medicine) =>
            medicine.startDate.isBefore(now) &&
            medicine.endDate.isAfter(now))
        .toList();
    //now filter the medicines based on time
    TimeOfDay currentTime = TimeOfDay.now();
    medicines = medicines
        .where((medicine) =>
            medicine.time.hour == currentTime.hour &&
            medicine.time.minute == currentTime.minute)
        .toList();
    //now delete the total dose to dose and update the medicine
    for (Medicine medicine in medicines) {
      medicine.dose = medicine.TotalDose - medicine.dose;
      await DatabaseHelper.updateMedicine(medicine);
    }
  }

  static Future<void> scheduleNotificationsForPeriod({
    required final int id,
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    required final DateTime startDate,
    required final DateTime endDate,
    required final TimeOfDay notificationTime,
  }) async {
    final TimeOfDay time = notificationTime;
    DateTime currentDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      time.hour,
      time.minute,
    );
    final TimeOfDay endTime = TimeOfDay(hour: 23, minute: 59);

    while (currentDate.isBefore(endDate)) {
      await showNotification(
        id: id,
        title: title,
        body: body,
        summary: summary,
        payload: payload,
        actionType: actionType,
        notificationLayout: notificationLayout,
        category: category,
        bigPicture: bigPicture,
        actionButtons: actionButtons,
        time: currentDate,
      );

      // Increment currentDate to the next day at the same time
      currentDate = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day + 1,
        time.hour,
        time.minute,
      );
    }

    // Schedule the notification for the end date if it's not already scheduled
    if (currentDate.isBefore(endDate)) {
      await showNotification(
        id: id,
        title: title,
        body: body,
        summary: summary,
        payload: payload,
        actionType: actionType,
        notificationLayout: notificationLayout,
        category: category,
        bigPicture: bigPicture,
        actionButtons: actionButtons,
        time: DateTime(
          endDate.year,
          endDate.month,
          endDate.day,
          endTime.hour,
          endTime.minute,
        ),
      );
    }
  }
}
