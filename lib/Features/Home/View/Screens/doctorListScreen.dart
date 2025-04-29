import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/doctorCard.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Admin/Controller/adminController.dart';
import 'package:homecare/Features/Home/Controller/doctorController.dart';

class DoctorsList extends StatelessWidget {
  final Doctorcontroller controller = Get.put(Doctorcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              color: Colors.grey[200],
              Images.wallPaper,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displayHeight(context)*0.05), // Move down by 10% of the screen height

              IconButton(
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: AppColors.primaryColor,
                ), onPressed: () {  Get.back();},
              ),
              SizedBox(height: 30), // 🔹 Spacing from the top

              Padding(
                padding: EdgeInsets.only(
                  right: displayWidth(context) * 0.03,
                  left: displayWidth(context) * 0.03,
                  top: displayHeight(context) * 0.01,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius:
                          BorderRadius.circular(displayWidth(context) * 0.06)),
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    // 🔹 تحديث البحث عند الكتابة
                    decoration: InputDecoration(
                      hintText: "Search doctors...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.filteredDoctors.isEmpty) {
                    return Center(child: Text('No doctors found.'));
                  }

                  return ListView.builder(
                    itemCount: controller.filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                          doctor: controller.filteredDoctors[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
