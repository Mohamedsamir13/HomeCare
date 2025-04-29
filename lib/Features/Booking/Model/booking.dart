class Appointment {
  final String userId;
  final String date;
  final String time;
  final String status;
  final DateTime createdAt;
  final String? doctorName; // ✅ أضفنا اسم الطبيب كـ optional

  Appointment({
    required this.userId,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
    this.doctorName, // ✅ أضفناها هنا
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'date': date,
    'time': time,
    'status': status,
    'createdAt': createdAt,
    if (doctorName != null) 'doctorName': doctorName, // ✅ فقط إذا موجود
  };
}
