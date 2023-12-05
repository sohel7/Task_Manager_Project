import 'package:copytaskmanager/screen/Splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        inputDecorationTheme:InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none

          ),
        ),
        textTheme: TextTheme(
          titleLarge:TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 18),
          )
        )
      ),
      home:  SplashScreen(),
    );
  }
}
