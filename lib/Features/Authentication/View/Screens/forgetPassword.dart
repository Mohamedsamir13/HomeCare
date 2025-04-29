import 'package:flutter/cupertino.dart' show StatelessWidget;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/View/Component/authTextField.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  ForgetPasswordScreen({super.key});

  void resetPassword() async {
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      Get.snackbar("Error", "Please enter a valid email address.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    bool result = await authController.resetPassword(emailController.text);
    if (result) {
      Get.snackbar("Success", "Password reset email sent successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to send password reset email.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your email to reset your password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            AuthTextField(
              controller: emailController,
              labelText: "Email", hintText: 'Enter Your Email',

            ),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: authController.isLoading.value ? () {} : resetPassword,
                text: "Reset Password",
                color: authController.isLoading.value ? Colors.grey : AppColors.primaryColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
