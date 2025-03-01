import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/size.dart';

class AuthTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Function()? onTap; // Add onTap as a component
  final bool  readOnly;

  // Use RxBool for reactive state management
  final RxBool isObscured = true.obs;

  AuthTextField({
    Key? key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.onTap, this.readOnly=false, // Initialize onTap in the constructor
  }) : super(key: key) {
    if (!obscureText) {
      isObscured.value = false; // Only enable toggle for password fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(
            () => GestureDetector(
          onTap: onTap, // Trigger the onTap when the field is tapped
          child: TextFormField(

            decoration: InputDecoration(
              fillColor: AppColors.secondaryColor, // Change this to any color you want

              labelText: labelText,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[600]),
              labelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: displayHeight(context) * 0.016,
                  horizontal: displayWidth(context) * 0.04),
              filled: true,

              // Visibility toggle for password field
              suffixIcon: obscureText
                  ? IconButton(
                icon: Icon(
                  isObscured.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  isObscured.value = !isObscured.value;
                },
              )
                  : null,
            ),
            controller: controller,
            obscureText: isObscured.value,
            style: const TextStyle(
              color: Colors.black,
            ),
            validator: validator,
            readOnly: readOnly,
          ),
        ),
      ),
    );
  }
}
