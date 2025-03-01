import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/View/Component/authTextField.dart';
import 'package:homecare/Features/Authentication/View/Screens/userDetails.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              color: Colors.grey[200],
              Images.wallPaper, // Using the same background image as LoginPage
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: displayHeight(context) * 0.03),
                child: Column(
                  children: [
                    SizedBox(height: displayHeight(context) * 0.05),
                    Image.asset(
                      Images.logo, // Using the same logo
                      height: displayHeight(context) * 0.2,
                    ),
                    SizedBox(height: displayHeight(context) * 0.03),
                    _buildSignUpForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Container(
      height: displayHeight(context) * 0.8,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        children: [
          AppText(
            text: 'SIGN UP',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: displayWidth(context) * 0.06,
          ),
          SizedBox(height: displayHeight(context) * 0.03),
          AuthTextField(
            hintText: "Enter your email",
            controller: emailController,
          ),
          SizedBox(height: displayHeight(context) * 0.03),
          AuthTextField(
            hintText: "Enter your password",
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: displayHeight(context) * 0.03),
          AuthTextField(
            hintText: "Re-enter your password",
            controller: confirmPasswordController,
            obscureText: true,
          ),
          SizedBox(height: displayHeight(context) * 0.03),
          AuthTextField(
            hintText: "Enter your full name",
            controller: fullNameController,
          ),
          SizedBox(height: displayHeight(context) * 0.03),
          _buildSignUpButton(),
          SizedBox(height: displayHeight(context) * 0.05),
          AppText(
            text: '_____________ Sign Up With _____________',
            size: displayWidth(context) * 0.04,
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: displayHeight(context) * 0.02),
          _buildSocialSignUp(),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Obx(() => CustomButton(
      text: "Next",
      isLoading: authController.isLoading.value,
      onPressed: () async {
        String email = emailController.text.trim();
        String password = passwordController.text;
        String confirmPassword = confirmPasswordController.text;
        String fullName = fullNameController.text.trim();

        // Validation and sign up logic
        if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty) {
          Get.snackbar("Missing Fields", "All fields are required", backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        if (!GetUtils.isEmail(email)) {
          Get.snackbar("Invalid Email", "Please enter a valid email address", backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        if (password.length < 6) {
          Get.snackbar("Weak Password", "Password must be at least 6 characters long", backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        if (password != confirmPassword) {
          Get.snackbar("Error", "Passwords do not match", backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        Get.to(() => UserDetailsScreen(
          email: email,
          password: password,
          fullName: fullName,
        ));
      },
    ));
  }

  Widget _buildSocialSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // TODO: Implement Google Sign Up
          },
          child: Image.asset(
            Images.google,
            height: displayHeight(context) * 0.04,
          ),
        ),
        SizedBox(width: displayWidth(context) * 0.08),
        GestureDetector(
          onTap: () {
            // TODO: Implement Facebook Sign Up
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
