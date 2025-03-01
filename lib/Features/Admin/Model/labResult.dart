class LabResult {
  String id;
  String userName;
  int visitNumber;
  DateTime visitDate;
  bool isCompleted;
  bool isPaymentCompleted;

  LabResult({
    required this.id,
    required this.userName,
    required this.visitNumber,
    required this.visitDate,
    required this.isCompleted,
    required this.isPaymentCompleted,
  });

  // Convert LabResult object to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'visitNumber': visitNumber,
      'visitDate': visitDate.toIso8601String(),
      'isCompleted': isCompleted,
      'isPaymentCompleted': isPaymentCompleted,
    };
  }

  // Create LabResult object from Firestore document
  factory LabResult.fromMap(Map<String, dynamic> map) {
    return LabResult(
      id: map['id'],
      userName: map['userName'],
      visitNumber: map['visitNumber'],
      visitDate: DateTime.parse(map['visitDate']),
      isCompleted: map['isCompleted'],
      isPaymentCompleted: map['isPaymentCompleted'],
    );
  }
}
