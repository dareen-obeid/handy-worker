import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String id;
  final String firstName;
  final String lastName;
  final String service;
  final String city;
  final String phone;
  final String email;
  final String photoUrl;



  Worker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.service,
    required this.city,
    required this.phone,   
    required this.email,
    required this.photoUrl,

    

  });

  factory Worker.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Worker(
      id: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      service: data['service'] ?? '',
      city: data['city'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',


    );
  }
}
