import 'package:flutter/material.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';


class CallUsScreen extends StatelessWidget {
  const CallUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const AppText(
          text: 'Call Us',
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.phone, size: 60, color: AppColors.accentColor),
            SizedBox(height: 20),
            AppText(
              text: 'Call us at: +20 123 456 7890',
              size: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            SizedBox(height: 10),
            AppText(
              text: 'Email: support@homecare.com',
              size: 16,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
