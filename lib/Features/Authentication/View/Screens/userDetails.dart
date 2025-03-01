import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Const/datePicker.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/Model/authModel.dart';
import 'package:homecare/Features/Authentication/View/Component/authTextField.dart';
import 'package:homecare/Features/Authentication/View/Component/authDropdown.dart';
import 'package:homecare/Features/Authentication/View/Screens/loginPage.dart';

class UserDetailsScreen extends StatelessWidget {
  final String email;
  final String password;
  final String fullName;

  UserDetailsScreen({required this.email, required this.password, required this.fullName});

  final AuthController authController = Get.find();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diagnosisDateController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> cancerTypes = ['Breast Cancer', 'Lung Cancer', 'Leukemia', 'Skin Cancer', 'Other'];
  final List<String> stages = ['Stage I', 'Stage II', 'Stage III', 'Stage IV'];

  final RxString selectedGender = ''.obs;
  final RxString selectedCancerType = ''.obs;
  final RxString selectedStage = ''.obs;

  bool _isValidPhoneNumber(String number) {
    final RegExp phoneRegex = RegExp(r'^(?:\+?\d{10,15})$');
    return phoneRegex.hasMatch(number);
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      diagnosisDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            color: Colors.grey[200],
            Images.wallPaper,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(displayWidth(context) * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_sharp, color: AppColors.primaryColor),
              ),
              SizedBox(height: displayHeight(context) * 0.05),
              Center(
                child: AppText(
                  text: 'Cancer Patient Information',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  size: displayWidth(context) * 0.06,
                ),
              ),
              SizedBox(height: displayHeight(context) * 0.05),

              AuthTextField(
                labelText: "Age",
                hintText: "Enter your age",
                controller: ageController,
                obscureText: false,
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              AuthDropdown<String>(
                hintText: "Select Gender",
                items: genders,
                selectedValue: selectedGender,
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              AuthDropdown<String>(
                hintText: "Select Cancer Type",
                items: cancerTypes,
                selectedValue: selectedCancerType,
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              AuthDropdown<String>(
                hintText: "Select Stage",
                items: stages,
                selectedValue: selectedStage,
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              DatePickerTextField(
                labelText: "Date of Diagnosis",
                hintText: "Enter date of diagnosis",
                controller: diagnosisDateController,
              ),

              SizedBox(height: displayHeight(context) * 0.02),

              AuthTextField(
                labelText: "Current Treatment",
                hintText: "Enter current treatment",
                controller: treatmentController,
                obscureText: false,
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              AuthTextField(
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                controller: phoneNumberController,
                obscureText: false,
              ),
              SizedBox(height: displayHeight(context) * 0.04),

              Obx(() => authController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                text: "Submit",
                onPressed: _isValidPhoneNumber(phoneNumberController.text)
                    ? () async {
                  UserModel newUser = UserModel(
                    uid: "",
                    email: email,
                    userType: "Patient",
                    age: int.tryParse(ageController.text) ?? 0,
                    gender: selectedGender.value,
                    cancerType: selectedCancerType.value,
                    stage: selectedStage.value,
                    dateOfDiagnosis: diagnosisDateController.text,
                    currentTreatment: treatmentController.text,
                    phoneNumber: phoneNumberController.text,
                    fullName: fullName,
                  );

                  User? user = await authController.signUpWithEmailAndPassword(newUser, password);

                  if (user != null) {
                    Get.snackbar("Success", "User Registered Successfully", snackPosition: SnackPosition.BOTTOM);
                    Get.to(LoginPage());
                  } else {
                    Get.snackbar("Error", "Registration Failed", snackPosition: SnackPosition.BOTTOM);
                  }
                }
                    : () {
                  Get.snackbar(
                    "Error",
                    "Please enter a valid phone number",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
                isLoading: authController.isLoading.value,
              )),
            ],
          ),
        ),
      ]),
    );
  }
}