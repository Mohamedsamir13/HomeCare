import 'package:flutter/material.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/images.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const AppText(
          text: 'About Us',
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Center(
              child: Image.asset(
                Images.logo,
                height: 120,
              ),
            ),
            const SizedBox(height: 30),

            // Section Title
            const AppText(
              text: 'Welcome to HomeCare',
              size: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Description Text
            const AppText(
              text:
              'HomeCare is a mobile application designed to help cancer patients make reservations for treatment or consultations, reducing overcrowding in hospitals and ensuring timely care. Our goal is to provide comfort and convenience while supporting the healthcare system.',
              size: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),

            // Optional: Add a motivational quote or support line
            const AppText(
              text: '"Care begins at your doorstep."',
              size: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.accentColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
