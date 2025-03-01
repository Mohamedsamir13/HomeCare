import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';

class LabResultController extends GetxController {
  Rxn<LabResult> latestLabResult = Rxn<LabResult>(); // أحدث نتيجة فقط
  RxBool isLoading = true.obs;
final userName =FirebaseAuth.instance.currentUser!.email.toString();
  @override
  void onInit() {
    listenToLatestLabResult(); // تحديث البيانات تلقائيًا عند أي تغيير
    super.onInit();
  }

  void listenToLatestLabResult() {
    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('lab_results')
        .where('userName', isEqualTo: userName)
        .get() // جلب البيانات بدون orderBy
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var docs = snapshot.docs.map((doc) => LabResult.fromMap(doc.data())).toList();
        docs.sort((a, b) => b.visitDate.compareTo(a.visitDate)); // ترتيب محلي بدل Firestore
        latestLabResult.value = docs.first; // جلب أحدث نتيجة بعد الفرز
      } else {
        latestLabResult.value = null;
      }
      isLoading.value = false;
    })
        .catchError((e) {
      print("Error fetching lab results: $e");
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load lab results');
    });
  }
}
