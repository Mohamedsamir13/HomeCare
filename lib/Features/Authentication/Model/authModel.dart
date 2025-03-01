class UserModel {
  final String uid;
  final String email;
  final String phoneNumber;
  final String userType;
  final int age;
  final String gender;
  final String cancerType;
  final String stage;
  final String dateOfDiagnosis;
  final String currentTreatment;
  final String fullName; // Added full name field

  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.age,
    required this.gender,
    required this.cancerType,
    required this.stage,
    required this.dateOfDiagnosis,
    required this.currentTreatment,
    required this.fullName,
  });

  // Convert UserModel to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "userType": userType,
      "age": age,
      "gender": gender,
      "cancerType": cancerType,
      "stage": stage,
      "dateOfDiagnosis": dateOfDiagnosis,
      "currentTreatment": currentTreatment,
      "createdAt": DateTime.now(),
    };
  }

  // Create a UserModel from Firebase data
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      phoneNumber: map["phoneNumber"],
      userType: map["userType"],
      age: map["age"],
      gender: map["gender"],
      cancerType: map["cancerType"],
      stage: map["stage"],
      dateOfDiagnosis: map["dateOfDiagnosis"],
      currentTreatment: map["currentTreatment"],
      fullName: map['fullName'],
    );
  }
}
