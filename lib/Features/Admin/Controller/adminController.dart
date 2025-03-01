import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:homecare/Features/Admin/Model/doctor.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addDoctor(Doctor doctor) async {
    try {
      await _firestore.collection('doctors').add(doctor.toJson());
      Get.snackbar('Success', 'Doctor added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add doctor: $e');
    }
  }
  Future<List<Map<String, dynamic>>> fetchBookings() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('appointments').get();
      return snapshot.docs.map((doc) {
        return {
          'userId': doc['userId'] ?? 'N/A',
          'date': doc['date'] ?? 'N/A',
          'time': doc['time'] ?? 'N/A',
          'status': doc['status'] ?? 'N/A',
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch bookings: $e');
      return [];
    }
  }
  // Function to add a new lab result
  Future<void> addLabResult(LabResult labResult) async {
    try {
      await _firestore.collection('lab_results').add(labResult.toMap());
      Get.snackbar('Success', 'Lab result added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add lab result: $e');
    }
  }

}