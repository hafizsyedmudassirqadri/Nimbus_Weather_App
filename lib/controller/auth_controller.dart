import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheather_app/constants/api_constants.dart';
import 'package:wheather_app/controller/api_controller.dart';
import 'package:wheather_app/view/bottom_navbar.dart';
import 'package:wheather_app/view/login_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isProtected = true.obs;

  void togglePasswordVisibility() {
    isProtected.value = !isProtected.value;
    
  }

  Future<void> login({required String email, required String pass}) async {
    isLoading.value = true;

    

    var myBody = {"email": email, "password": pass};
    var response = await ApiController().post(
      url: ApiConstants.loginApi,
      body: myBody,
    );

    isLoading.value = false;
    

    if ((response.$1 == 200) || (response.$1 == 201)) {
    
      var loginResponse = jsonDecode(response.$2);
      String token = loginResponse["token"];
      await ApiController().saveToken(token: token);
      final name = loginResponse["user"]?["name"]?.toString().trim();
      if (name != null && name.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', name);
      }
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.greenAccent,
        "Login Succesfull",
        loginResponse["user"]["name"] ?? "You have successfully logged in.",
      );
      Get.offAll(() => BottomNavigation());
    } else {
      var loginResponse = jsonDecode(response.$2);
      var loginError = loginResponse['error']['message'];
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.redAccent,
        "Login Failed",
        loginError ?? "An error occurred during login.",
      );
    }
  }


Future<void> sigupAuth({required String email, required String pass, required String name}) async {
    isLoading.value = true;
    // String email = emailText.text;
    // String pass = passText.text;
    // String name = fullNameText.text;
  
   

    var myBody = {"email": email, "password": pass, "name": name.trim()};
    var response = await ApiController().post(
      url: ApiConstants.registerApi,
      body: myBody,
    );
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  
    print("RESPONSE ${response.$2}");
    if ((response.$1 == 200) || (response.$1 == 201)) {
     
      var registerResponse = jsonDecode(response.$2);
      String token = registerResponse["token"];
      await ApiController().saveToken(token: token);
      final registeredName =
          registerResponse["user"]?["name"]?.toString().trim();
      final savedName = (registeredName == null || registeredName.isEmpty)
          ? name.trim()
          : registeredName;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', savedName);
      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.greenAccent,
        "Registration Successful",
        registerResponse["user"]["name"] ?? "You have successfully registered.",
      );
      Get.offAll(() => LoginScreenUi());
    } else {
      var registerResponse = jsonDecode(response.$2);
      var registerError = registerResponse['error'] ['message'];

      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.redAccent,
        "Registration Failed",
        registerError ?? "An error occurred during registration.",
      );
    }
  }


 @override
  void onInit() {
   
    super.onInit(); 
  }
 @override
  void onReady() {
   authMeSplash();
    super.onReady(); 
  }


  

   Future<void> authMeSplash() async {
    // await Future.delayed(Duration(seconds: 2));
    // var route = MaterialPageRoute(builder: (login) => LoginScreenUi());
    // Navigator.pushReplacement(context, route);
    // setState(() {});

    var response = await ApiController().get(
      url: ApiConstants.rememberMe,
      isToken: true,
    );
    if (response.$1 == 200 || response.$1 == 201) {
      try {
        final profile = jsonDecode(response.$2);
        final name = profile["user"]?["name"]?.toString().trim();
        if (name != null && name.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_name', name);
        }
      } catch (_) {}
      Get.offAll( () => BottomNavigation());
    }
    else{
      Get.offAll( () => LoginScreenUi());
    }

  }
}
