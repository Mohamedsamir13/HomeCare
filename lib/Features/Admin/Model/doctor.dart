import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name;
  final String description;
  final String location;
  final double price;
  final String phoneNumber;
  final double rating;
  final String imageUrl; // ✅ Added image field

  Doctor({
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    required this.phoneNumber,
    required this.rating,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'price': price,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'imageUrl': imageUrl, // ✅ Include image in Firestore
    };
  }
}
