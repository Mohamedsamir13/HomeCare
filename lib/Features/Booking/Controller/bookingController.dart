import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homecare/Features/Booking/Model/booking.dart';
import 'package:homecare/Features/Booking/View/splaishScreen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  final RxList<String> bookedTimes = <String>[].obs;
  final RxBool isLoading = false.obs;

  final List<TimeOfDay> availableTimes = const [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 15, minute: 0),
  ];

  final RxList<TimeOfDay> filteredAvailableTimes = <TimeOfDay>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedDate, (_) => fetchBookedTimes());
    fetchBookedTimes();
  }

  void fetchBookedTimes() async {
    try {
      isLoading(true);
      final query = _firestore
          .collection('appointments')
          .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate.value));

      query.snapshots().listen((snapshot) {
        bookedTimes.value = snapshot.docs.map((doc) => doc['time'].toString()).toList();

        // تحديث الأوقات المتاحة بعد استبعاد المحجوزة
        updateAvailableTimes();
      });
    } finally {
      isLoading(false);
    }
  }

  void updateAvailableTimes() {
    filteredAvailableTimes.value = availableTimes.where((time) {
      final timeString = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
      return !bookedTimes.contains(timeString);
    }).toList();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    fetchBookedTimes();
  }

  void selectTime(TimeOfDay time) => selectedTime.value = time;

  Future<void> bookAppointment() async {
    if (selectedTime.value == null) {
      Get.snackbar('Error', 'Please select a time');
      return;
    }

    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'Please login first');
        return;
      }

      final appointment = Appointment(
        userId: FirebaseAuth.instance.currentUser!.email.toString(),
        date: DateFormat('yyyy-MM-dd').format(selectedDate.value),
        time: '${selectedTime.value!.hour}:${selectedTime.value!.minute.toString().padLeft(2, '0')}',
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _firestore.collection('appointments').add(appointment.toJson());

      // تحديث القائمة بعد الحجز مباشرةً
      bookedTimes.add(appointment.time);
      updateAvailableTimes();

      Future.delayed(const Duration(seconds: 1), () {
        Get.to(() => SplashScreen());
      });
      Get.back();
      Get.snackbar('Success', 'Appointment booked successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment: $e');
    }
  }
}
