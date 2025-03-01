class Appointment {
  final String userId;
  final String date;
  final String time;
  final String status;
  final DateTime createdAt;

  Appointment({
    required this.userId,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'date': date,
    'time': time,
    'status': status,
    'createdAt': createdAt,
  };
}