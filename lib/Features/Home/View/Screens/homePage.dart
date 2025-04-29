  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:homecare/Const/appColor.dart';
  import 'package:homecare/Const/appText.dart';
  import 'package:homecare/Const/images.dart';
  import 'package:homecare/Const/size.dart';
  import 'package:homecare/Features/Admin/View/Screens/adminHomePage.dart';
import 'package:homecare/Features/Authentication/Controller/authController.dart';
import 'package:homecare/Features/Authentication/View/Screens/loginPage.dart';
  import 'package:homecare/Features/Booking/View/bookingScreen.dart';
import 'package:homecare/Features/Home/View/Screens/aboutUs.dart';
import 'package:homecare/Features/Home/View/Screens/callUs.dart';
  import 'package:homecare/Features/Home/View/Screens/doctorListScreen.dart';
  import 'package:homecare/Features/Lap/Views/Screen/labResultList.dart';

  class Homepage extends StatefulWidget {
    const Homepage({super.key});

    @override
    State<Homepage> createState() => _HomepageState();
  }

  class _HomepageState extends State<Homepage> {
    final String adminUid = "BB6oBTyINbSULcgWed0Ld5Ath0T2";// Admin UID
    final String seif = "Wg5ErLGvmbhCYVdMCYZ2o345QxB3";// Admin UID
    final String nour = "Ta549RGamuPJm057e0V3HQNMAqR2";// Admin UID
    bool isAdmin = false;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final AuthController controller = Get.put(AuthController());
    @override
    void initState() {
      super.initState();
      checkIfAdmin();
    }

    void checkIfAdmin() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.uid == adminUid||user!.uid == seif||user.uid==nour) {
        setState(() {
          isAdmin = true;
        });
      }
    }


    Future<void> _logout() async {
      try {
        await FirebaseAuth.instance.signOut();
        Get.off(LoginPage()); // Replace with your login route
      } catch (e) {
        Get.snackbar('Error', 'Failed to logout: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                color: Colors.grey[200],
                Images.wallPaper,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: displayHeight(context)*0.05), // Move down by 10% of the screen height

                  IconButton(
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    icon: Icon(Icons.menu, color: AppColors.primaryColor),
                  ),
                  SizedBox(height: displayHeight(context)*0.1),
                  Center(child: AppText(text: 'Choose your category', fontWeight: FontWeight.w700, color: AppColors.primaryColor)),
                  SizedBox(height: displayHeight(context)*0.03),
                  Center(child: _buildHeader('General Authority for Health Insurance', Images.insurance)),
                  SizedBox(height: displayHeight(context)*0.03),
                  GestureDetector(onTap: ()=>Get.to(LabResultPage()), child: _buildCategoryCard('Lab Results', Images.lap)),
                  SizedBox(height: 16),
                  GestureDetector(
                    child: _buildCategoryCard('Find your perfect doctor', Images.search),
                    onTap: () => Get.to(DoctorsList()),
                  ),
                  if (isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => Get.to(AdminHomePage()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
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

    Widget _buildDrawer() {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: FirebaseAuth.instance.currentUser?.email ?? 'Guest',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: AppColors.primaryColor),
              title: AppText(text: 'About Us'),
              onTap: () {
                Get.back(); // Close drawer
                Get.to(AboutUsScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: AppColors.primaryColor),
              title: AppText(text: 'Call Us'),
              onTap: () {
Get.to(CallUsScreen());              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: AppText(text: 'Logout', color: Colors.red),
              onTap: _logout,
            ),
          ],
        ),
      );
    }

    Widget _buildCategoryCard(String title, String image) {
      return Card(
        color: AppColors.secondaryColor,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: displayHeight(context)*0.03,
            horizontal: displayWidth(context)*0.05,
          ),
          child: Row(
              children: [
                Image.asset(image),
                SizedBox(width: displayWidth(context)*0.05),
                AppText(
                  text: title,
                  size: displayWidth(context)*0.05,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ]
          ),
        ),
      );
    }

    Widget _buildHeader(String title, String image) {
      return Card(
        color: AppColors.secondaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
              SizedBox(height: displayHeight(context) * 0.02),
              ElevatedButton(
                onPressed: () => Get.to(AppointmentView()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical: displayHeight(context) * 0.01,
                    horizontal: displayWidth(context) * 0.04,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Book Your Appointment',
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.033,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }