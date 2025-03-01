import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Admin/View/Screens/adminHomePage.dart';
import 'package:homecare/Features/Booking/Controller/bookingController.dart';
import 'package:homecare/Features/Booking/View/bookingScreen.dart';
import 'package:homecare/Features/Home/View/Screens/doctorListScreen.dart';
import 'package:homecare/Features/Lap/Views/Screen/labResultList.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String adminUid = "BB6oBTyINbSULcgWed0Ld5Ath0T2"; // Admin UID
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkIfAdmin();
  }

  void checkIfAdmin() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.uid == adminUid) {
      setState(() {
        isAdmin = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
      Positioned.fill(
      child: Image.asset(
        color: Colors.grey[200],
        Images.wallPaper,
        fit: BoxFit.cover,
      ),
    ),
      Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: AppColors.primaryColor,)),
            SizedBox(height: displayHeight(context)*0.1),

            Center(child: AppText(text: 'Choose your category',fontWeight: FontWeight.w700,color: AppColors.primaryColor,)),
             SizedBox(height: displayHeight(context)*0.03),
            Center(child: _buildHeader('General Authority for Health Insurance', Images.insurance)),
            SizedBox(height: displayHeight(context)*0.03),

            GestureDetector(onTap: ()=>Get.to(LabResultPage()),child: _buildCategoryCard('Lab Results', Images.lap)),
             SizedBox(height: 16),
            GestureDetector(child: _buildCategoryCard('Find your perfect doctor', Images.search,),onTap:()=> Get.to(DoctorsList()),),
            if (isAdmin)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(AdminHomePage()); // Navigate to Admin Home Page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Admin button color
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Go to Admin Home Page',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
        ],
      ),
    );
  }



  Widget _buildCategoryCard(String title, String image) {
    return GestureDetector(
      child: Card(
        color: AppColors.secondaryColor,
        elevation: 2,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: displayHeight(context)*0.03,horizontal: displayWidth(context)*0.05),
          child: Row(
            children: [
              Image.asset(image),
               SizedBox(width: displayWidth(context)*0.05),
              AppText(
               text:  title,
                size: displayWidth(context)*0.05, fontWeight: FontWeight.w700,color: AppColors.primaryColor,),
            ]
          ),
        ),
      ),
    );
  }
  Widget _buildHeader(String title, String image) {
    return Card(
      color: AppColors.secondaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: displayHeight(context) * 0.01,
          horizontal: displayWidth(context) * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 70),
            AppText(
              text: title,
              size: displayWidth(context) * 0.04,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: displayHeight(context) * 0.02), // Add spacing
            ElevatedButton(
              onPressed: () {
                Get.to(AppointmentView());// Add your onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Button color
                padding: EdgeInsets.symmetric(
                  vertical: displayHeight(context) * 0.01,
                  horizontal: displayWidth(context) * 0.04,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              child: Text(
                'Book Your Appointment',
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.033,
                  fontWeight: FontWeight.w700,
                  color: Colors.white, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}