import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/screens/splash_screen.dart';
import 'package:grocery_app/presentation/styles/theme.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
