import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Admin/Model/doctor.dart';
import 'package:homecare/Features/Booking/Controller/bookingController.dart';
import 'package:homecare/Features/Booking/View/bookingScreen.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    double height = displayHeight(context);
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: NetworkImage(doctor.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: doctor.name,
                    size: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: height * 0.005),
                  AppText(
                    text: doctor.description,
                    size: width * 0.035,
                    color: Colors.grey[600],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Icon(Icons.phone, size: width * 0.04, color: AppColors.primaryColor),
                      SizedBox(width: width * 0.02),
                      AppText(text: doctor.phoneNumber, size: width * 0.035, color: Colors.grey[600]),
                      SizedBox(width: width * 0.07),
                      Icon(Icons.price_change, size: width * 0.04, color: AppColors.primaryColor),
                      SizedBox(width: width * 0.02),
                      AppText(
                        text: '${doctor.price.toStringAsFixed(0)} EGP',
                        size: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.005),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: width * 0.04, color: Colors.grey),
                      SizedBox(width: width * 0.02),
                      AppText(text: doctor.location, size: width * 0.035, color: Colors.grey[600]),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      // Display stars dynamically
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < doctor.rating.floor() ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: width * 0.04,
                          );
                        }),
                      ),
                      SizedBox(width: width * 0.02),
                      AppText(
                        text: ' ${doctor.rating.toStringAsFixed(1)}',
                        size: width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: width * 0.04),
                      ElevatedButton(
                        onPressed: () {
                          final doctorName = doctor.name; // Just the name of the doctor

                          final drAppoinmentsController = Get.put(AppointmentController());
                          drAppoinmentsController.selectDoctor(doctor);
                          Get.to(() => AppointmentView()); // Pass only the doctor name
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: AppText(
                          text: 'Book',
                          size: width * 0.035,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
