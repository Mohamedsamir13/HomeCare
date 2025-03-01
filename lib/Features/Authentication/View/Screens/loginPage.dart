import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/View/Component/authTextField.dart';
import 'package:homecare/Features/Authentication/View/Screens/registerPage.dart';
import 'package:homecare/Features/Home/View/Screens/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              color: Colors.grey[200],
              Images.wallPaper,
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
                      Images.logo,
                      height: displayHeight(context) * 0.2,
                    ),
                    SizedBox(height: displayHeight(context) * 0.05),
                    _buildLoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      height: displayHeight(context) * 0.75,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppText(
              text: 'LOG IN',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              size: displayWidth(context) * 0.06,
            ),
            SizedBox(height: displayHeight(context) * 0.03),
            AuthTextField(
              hintText: "Enter your email",
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
            ),
            SizedBox(height: displayHeight(context) * 0.03),
            AuthTextField(
              // labelText: "Password",
              hintText: "Enter your password",
              controller: passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                       Get.to(SignUpScreen()); // TODO: Implement Forgot Password functionality
                      },
                      child: AppText(
                        color: Colors.white,
                        text: 'Create new account.',
                        size: displayWidth(context) * 0.035,
                        fontWeight: FontWeight.w500,
                        underline: true,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement Forgot Password functionality
                      },
                      child: AppText(
                        color: Colors.white,
                        text: 'Forgot Password?',
                        size: displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: displayHeight(context) * 0.04),
            _buildLoginButton(),
            SizedBox(height: displayHeight(context) * 0.05),
            AppText(
              text: '_____________ Sign Up With _____________',
              size: displayWidth(context) * 0.04,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: displayHeight(context) * 0.05),
            _buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() => CustomButton(
          text: "Sign In",
          isLoading: authController.isLoading.value,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              bool success = await authController.signInWithEmailAndPassword(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
              if (success) {
                Get.snackbar("Success", "Login successful",
                    snackPosition: SnackPosition.BOTTOM);
                Get.to(Homepage());
              } else {
                Get.snackbar("Error", "Invalid email or password",
                    snackPosition: SnackPosition.BOTTOM);
              }
            }
          },
        ));
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ()async {
            User? user = await authController.signInWithGoogle();
            if (user != null) {
              Get.to(Homepage());// Handle successful Google login
              Get.snackbar("Success", "Google Login Successful");
            } else {
              // Handle failed Google login
              Get.snackbar("Error", "Google Login Failed");
            }
    }, // TODO: Implement Google Login

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
