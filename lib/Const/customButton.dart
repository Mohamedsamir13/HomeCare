import 'package:flutter/material.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/size.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color; // Make the color parameter optional
  final BorderSide? borderSide; // Add BorderSide parameter

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color, // Optional color parameter
    this.borderSide, // Optional borderSide parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the provided color if available, otherwise use the primary color from the theme
    final buttonColor = color ?? AppColors.primaryColor;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 7,
        backgroundColor: buttonColor, // Use the determined color
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.34,
          vertical: displayHeight(context) * 0.012,
        ),
        side: borderSide ?? BorderSide.none, // Use the provided borderSide or none
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context)*0.08), // Optional: Add border radius
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : AppText(text: text, color: Colors.white),
    );
  }
}