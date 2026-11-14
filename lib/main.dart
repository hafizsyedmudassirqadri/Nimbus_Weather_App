import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheather_app/controller/auth_controller.dart';
import 'package:wheather_app/view/splash_screen.dart';

void main() {
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreenUi(),
    );
  }
}

