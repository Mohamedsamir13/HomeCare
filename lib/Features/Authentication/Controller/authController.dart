import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homecare/Features/Authentication/Model/authModel.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }
  Future<bool> resetPassword(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      print('Failed to reset password: $e');
      return false;
    }
  }

  // Sign Up
  Future<User?> signUpWithEmailAndPassword(
      UserModel user, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      user = UserModel(
        uid: userCredential.user!.uid,
        email: user.email,
        phoneNumber: user.phoneNumber,
        userType: user.userType,
        age: user.age,
        gender: user.gender,
        cancerType: user.cancerType,
        stage: user.stage,
        dateOfDiagnosis: user.dateOfDiagnosis,
        currentTreatment: user.currentTreatment,
        fullName: user.fullName,
      );

      await saveUserData(user);

      isLoading.value = false;
      return userCredential.user;
    } catch (e) {
      isLoading.value = false;
      print('Error signing up: $e');
      return null;
    }
  }

  // Save User Data to Firestore
  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestore.collection("USERS_DATA").doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Sign In with Email and Password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      print('Failed to sign in: $e');
      return false;
    }
  }

  // Sign In with Google
  Future<User?> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return null; // User canceled the sign-in
      }

      // Get the authentication details from Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Check if the user is logged in

      isLoading.value = false;
      return user;
    } catch (e) {
      isLoading.value = false;
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut(); // Also sign out from Google
  }
}
