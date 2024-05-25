import 'package:flutter/material.dart';
import 'package:medicine_reminder/Register/login.dart';
import 'package:medicine_reminder/local_notification.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the local notification
  await LocalNotification.initializeNotification();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      navigatorKey: navigatorKey,
      darkTheme: ThemeData(
          primaryColor: Colors.blue,
          brightness: Brightness.dark
      ),
      // themeMode: ThemeMode.dark ,
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
        brightness: Brightness.light ,                                                           
        useMaterial3: false
        ),
      home:Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

 