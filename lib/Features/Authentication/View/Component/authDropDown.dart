import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/size.dart';

class AuthDropdown<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final Rx<T> selectedValue;
  final String? labelText;
  final double? fontSize; // Added fontSize parameter

  AuthDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    this.labelText,
    this.fontSize, // Initialize fontSize in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),

      width: displayWidth(context)*0.92,
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          contentPadding:              EdgeInsets.symmetric(vertical: displayHeight(context)*0.016, horizontal: displayWidth(context)*0.02),

        ),
        value: selectedValue.value != null && selectedValue.value != ''
            ? selectedValue.value
            : null,
        hint: Text(
          hintText,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: fontSize ?? 14.0, // Optional font size, default to 14.0
          ),
        ),
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              value.toString(),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: fontSize ?? 20.0, // Set font size for the dropdown items
              ),
            ),
          );
        }).toList(),
        onChanged: (value) => selectedValue.value = value!,
      ),
    ));
  }
}
