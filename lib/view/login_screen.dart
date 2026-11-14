import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app/constants/api_constants.dart';
import 'package:wheather_app/constants/app_colors.dart';
import 'package:wheather_app/controller/auth_controller.dart';
import 'package:wheather_app/view/home_screen.dart';
import 'package:wheather_app/view/signup_screen.dart';

// https://dummyjson.com/docs/auth

class LoginScreenUi extends StatefulWidget {
  const LoginScreenUi({super.key});

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi> {
  AuthController authController = Get.find<AuthController>();

  TextEditingController emailText = TextEditingController(
    text: "demo@nimbus.app",
  );
  TextEditingController passText = TextEditingController(text: "demo1234");

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardOpen = keyboardHeight > 0;
    return Scaffold(
      backgroundColor: AppColors.lightThemeBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.09,
          vertical: screenheight * 0.08,
        ),
        child: SingleChildScrollView(
          physics: isKeyboardOpen
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  var loginRoute = MaterialPageRoute(
                        builder: (login) => SignupScreenUi(),
                      );
                      Navigator.push(context, loginRoute);
                },
                child: Container(
                  
                  padding: EdgeInsets.symmetric(
                    horizontal: screenwidth * 0.03,
                    vertical: screenheight * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.asset("assets/Icon/login sun.png",
                  height: screenheight*0.07,
                  width: screenwidth*0.16,
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.01),
              Text(
                "Welcome Back",
                style: GoogleFonts.sora(
                  color: AppColors.lightThemePrimaryText,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenheight * 0.007),
              Text(
                "Login in to see Weather for the cities you care about",
                style: GoogleFonts.sora(
                  color: AppColors.lightThemeSecondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenheight * 0.02),
              Text(
                "Email",
                style: GoogleFonts.sora(
                  color: AppColors.lightThemeSecondaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenheight * 0.007),
              TextField(
                textInputAction: TextInputAction.next,
                controller: emailText,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  fillColor: Color(0xFFFFFFFF),
                  filled: true,

                  hintText: "you@email.com",
                  hintStyle: const TextStyle(
                    color: AppColors.lightThemeSecondaryText,
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                  prefixIconColor: AppColors.lightThemeSecondaryText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColors.lightThemeSecondaryText,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.01),
              Text(
                "Password",
                style: GoogleFonts.sora(
                  color: AppColors.lightThemeSecondaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenheight * 0.007),
              Obx(
                () => TextField(
                  controller: passText,
                  obscureText: authController.isProtected.value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,

                    hintText: "Enter Your Password",
                    hintStyle: const TextStyle(
                      color: AppColors.lightThemeSecondaryText,
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: AppColors.lightThemeSecondaryText,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColors.lightThemeSecondaryText,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                    ),

                    suffixIcon: IconButton(
                      onPressed: authController.togglePasswordVisibility,

                      icon: authController.isProtected.value
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.lightThemeSecondaryText,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: AppColors.lightThemeSecondaryText,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.06),
              GetBuilder<AuthController>(
                builder: (c) {
                  return SizedBox(
                    width: double.infinity,
                    height: screenheight * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: AppColors.textButton,
                      ),
                      onPressed: () {
                        if (emailText.text.isEmpty && passText.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please fill in all fields.",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          authController.Login(
                            email: emailText.text,
                            pass: passText.text,
                          );
                        }
                      },
                      child: authController.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "LogIn",
                              style: GoogleFonts.sora(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),

              SizedBox(height: screenheight * 0.14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.sora(
                      color: Colors.deepPurpleAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w100,
                    ),
                  ),

                  SizedBox(width: screenwidth * 0.006),
                  TextButton(
                    child: Text(
                      "SignUp",
                      style: GoogleFonts.sora(
                        color: AppColors.textButton,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      var loginRoute = MaterialPageRoute(
                        builder: (login) => SignupScreenUi(),
                      );
                      Navigator.push(context, loginRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
