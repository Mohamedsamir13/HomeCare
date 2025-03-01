import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/size.dart';

class DatePickerTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Function()? onTap; // Add onTap as a component
  final bool readOnly;

  DatePickerTextField({
    Key? key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onTap,
    this.readOnly = false, // Default is editable
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      controller.text = "${picked.toLocal()}".split(' ')[0]; // Format the date as YYYY-MM-DD
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          if (!readOnly) {
            _selectDate(context); // Trigger the date picker when the field is tapped
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
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
                horizontal: displayWidth(context) * 0.02,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
            ),
            validator: validator,
            readOnly: readOnly, // Make the text field read-only if needed
          ),
        ),
      ),
    );
  }
}
