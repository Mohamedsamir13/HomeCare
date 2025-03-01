import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:homecare/Features/Admin/Model/doctor.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';

class Doctorcontroller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var doctorsList = <Doctor>[].obs;
  var filteredDoctors = <Doctor>[].obs; // 🔹 قائمة الأطباء بعد التصفية
  var isLoading = true.obs;
  var searchQuery = ''.obs; // 🔹 نص البحث
  StreamSubscription<QuerySnapshot>? _doctorsSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupDoctorsStream();
  }

  void _setupDoctorsStream() {
    isLoading.value = true;

    _doctorsSubscription = _firestore.collection('doctors').snapshots().listen(
          (snapshot) {
        doctorsList.value = snapshot.docs.map((doc) {
          return Doctor(
            name: doc['name'] ?? 'No Name',
            description: doc['description'] ?? 'No Description',
            location: doc['location'] ?? 'Unknown Location',
            price: (doc['price'] ?? 0).toDouble(),
            phoneNumber: doc['phoneNumber'] ?? 'No Phone',
            rating: (doc['rating'] ?? 0).toDouble(),
            imageUrl: doc['imageUrl'] ?? '',
          );
        }).toList();
        filterDoctors();
        isLoading.value = false;
      },
      onError: (error) {
        print("❌ Firestore Error: $error");
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to load doctors: $error');
      },
    );
  }

  // 🔹 فلترة الأطباء حسب البحث
  void filterDoctors() {
    if (searchQuery.value.isEmpty) {
      filteredDoctors.value = doctorsList;
    } else {
      filteredDoctors.value = doctorsList
          .where((doctor) =>
          doctor.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  // 🔹 تحديث نص البحث
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterDoctors();
  }

  @override
  void onClose() {
    _doctorsSubscription?.cancel();
    super.onClose();
  }
}
