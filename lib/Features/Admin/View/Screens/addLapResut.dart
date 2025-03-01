import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/adminTextField.dart';
import 'package:homecare/Const/datePicker.dart';
import 'package:homecare/Features/Admin/Controller/adminController.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';

class AddLabResultPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());
  final TextEditingController visitNumberController = TextEditingController();
  final TextEditingController visitDateController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final RxBool isCompleted = false.obs;
  final RxBool isPaymentComplete = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Lab Result')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach form key
          child: Column(
            children: [
              CustomTextField(
                controller: visitNumberController,
                hintText: 'Visit Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Visit Number is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: userNameController,
                hintText: 'userName',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'UserName  is required';
                  }

                  return null;
                },
              ),
              DatePickerTextField(
                controller: visitDateController,
                hintText: 'Visit Date',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Visit Date is required';
                  }
                  if (DateTime.tryParse(value) == null) {
                    return 'Enter a valid date';
                  }
                  return null;
                },
              ),
              Obx(() => CheckboxListTile(
                title: Text('Completed'),
                value: isCompleted.value,
                onChanged: (value) => isCompleted.value = value!,
              )),
              Obx(() => CheckboxListTile(
                title: Text('Payment Complete'),
                value: isPaymentComplete.value,
                onChanged: (value) => isPaymentComplete.value = value!,
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final labResult = LabResult(
                      id: UniqueKey().toString(),
                      visitNumber: int.parse(visitNumberController.text),
                      visitDate: DateTime.parse(visitDateController.text),
                      isCompleted: isCompleted.value,
                      userName: userNameController.text,
                      isPaymentCompleted: isPaymentComplete.value,
                    );

                    controller.addLabResult(labResult);
                    Get.snackbar("Success", "Lab result added successfully",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text('Save Lab Result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
