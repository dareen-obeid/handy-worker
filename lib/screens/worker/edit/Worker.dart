
class Worker {
  final String uid;
  final String firstName;
  final String lastName;
  final String service;
  final String city;
  final String phone;
  final String email;
  final String photoUrl;
  final String description;
  final Map<String, String> availability;

  Worker({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.service,
    required this.city,
    required this.phone,
    required this.email,
    required this.photoUrl,
    required this.description,
    required this.availability,
  });

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      service: map['service'],
      city: map['city'],
      phone: map['phone'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      description: map['description'],
      availability: Map<String, String>.from(map['availability']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'service': service,
      'city': city,
      'phone': phone,
      'email': email,
      'photoUrl': photoUrl,
      'description': description,
      'availability': availability,
    };
  }

    }