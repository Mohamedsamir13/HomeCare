import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/adminTextField.dart';
import 'package:homecare/Features/Admin/Controller/adminController.dart';
import 'package:homecare/Features/Admin/Model/doctor.dart';

class AddDoctorPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController(); // ✅ إضافة حقل للصورة


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Add Doctor')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: nameController, hintText: 'Doctor Name'),
            CustomTextField(controller: descController, hintText: 'Description'),
            CustomTextField(controller: locationController, hintText: 'Location'),
            CustomTextField(controller: priceController, hintText: 'Price'),
            CustomTextField(controller: phoneController, hintText: 'Phone Number'),
            CustomTextField(controller: ratingController, hintText: 'Rating'),
            CustomTextField(controller: imageUrlController, hintText: 'Image URL'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final doctor = Doctor(
                  imageUrl: imageUrlController.text,
                  name: nameController.text,
                  description: descController.text,
                  location: locationController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  phoneNumber: phoneController.text,
                  rating: double.tryParse(ratingController.text) ?? 0.0,
                );

                controller.addDoctor(doctor);
              },
              child: Text('Save Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}