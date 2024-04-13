import 'package:flutter/material.dart';
import 'package:medicine_reminder/Register/login.dart';

import 'package:medicine_reminder/addMeds.dart';
import 'package:medicine_reminder/bottomNav.dart';
import 'package:medicine_reminder/homeppage.dart';
import 'package:medicine_reminder/local_notification.dart';
// import 'package:medicine_reminder/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Local_Notification.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
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

 