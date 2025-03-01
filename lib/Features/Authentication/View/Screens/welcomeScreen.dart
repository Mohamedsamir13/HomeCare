import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/View/Screens/loginPage.dart';
import 'package:homecare/Features/Authentication/View/Screens/registerPage.dart';
import 'package:homecare/Features/Home/View/Screens/homePage.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Images.wallPaper,
              color: Colors.grey[200],
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Keeps elements spaced properly
              children: [
                SizedBox(height: displayHeight(context) * 0.1), // Adjust spacing from top
                Column(
                  children: [
                    Center(
                      child: Image.asset(
                        Images.logo,
                        height: displayHeight(context) * 0.2,
                      ),
                    ),
                    SizedBox(height: displayHeight(context) * 0.05),
                    CustomButton(
                      text: 'SIGN UP',
                      onPressed: () => Get.to(SignUpScreen()),
                    ),
                    SizedBox(height: displayHeight(context) * 0.03),
                    CustomButton(
                      text: 'LOG IN',
                      onPressed: () => Get.to(LoginPage()),
                      color: AppColors.secondaryColor,
                      borderSide: BorderSide(
                        color: AppColors.secondaryColor,
                        width: 3,
                      ),
                    ),
                    SizedBox(height: displayHeight(context) * 0.02),
                    AppText(
                      text: 'Create an account ? ',
                      underline: true,
                      color: AppColors.primaryColor,
                      size: displayWidth(context) * 0.035,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildSocialLogin(),
                    SizedBox(height: displayHeight(context) * 0.04),
                    Container(
                      width: displayWidth(context) * 0.4,
                      height: 4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),                      color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: displayHeight(context) * 0.05),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            User? user = await authController.signInWithGoogle();
            if (user != null) {
              Get.to(Homepage());
              Get.snackbar("Success", "Google Login Successful");
            } else {
              Get.snackbar("Error", "Google Login Failed");
            }
          },
          child: Image.asset(
            Images.google,
            height: displayHeight(context) * 0.04,
          ),
        ),
        SizedBox(width: displayWidth(context) * 0.08),
        GestureDetector(
          onTap: () {
            // TODO: Implement Facebook Login
          },
          child: Image.asset(
            Images.facebook,
            height: displayHeight(context) * 0.04,
          ),
        ),
      ],
    );
  }
}
