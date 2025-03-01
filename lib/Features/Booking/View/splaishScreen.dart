import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Home/View/Screens/homePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Get.to(Homepage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Positioned.fill(
      child: Image.asset(
        color: Colors.grey[200],
        Images.wallPaper,
        fit: BoxFit.cover,
      ),
    ),
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: displayWidth(context) * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkmark Image
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  Images.done,
                ),
              ),
              // Success Message
              Padding(
                padding: EdgeInsets.only(bottom: displayHeight(context) * 0.04),
                child: AppText(
                  text: 'Your appointment \nhas been successfully booked!',
                  size: displayWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ]
    )

    );
  }
}