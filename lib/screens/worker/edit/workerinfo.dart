import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../reusable_widgets/reusable_widget.dart';
import 'Worker.dart';
import 'WorkerProvider.dart';

class WorkerInformationPage extends StatefulWidget {
  final String uid;

  const WorkerInformationPage({required this.uid});

  @override
  _WorkerInformationPageState createState() => _WorkerInformationPageState();
}

class _WorkerInformationPageState extends State<WorkerInformationPage> {
// @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     email = user?.email ?? ' ';
//     name;
//     service;
//     city;
//     phone;
//     photoUrl;
//     description;
//     id;
//     _loadData();

//   }

//   late String email;
//   late String name = "";
//   late String id = "";

//   late String service = "";
//   late String city = "";
//   late String phone = "";
//   late String photoUrl = "";
//   late String description = "";

//   Future<void> _loadData() async {
//     final uEmail = FirebaseAuth.instance.currentUser!.email;
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('workers')
//         .where('email', isEqualTo: uEmail)
//         .get();
//     if (querySnapshot.docs.isNotEmpty) {
//       var data = querySnapshot.docs[0].data();
//       var firstName = data['firstName'];
//       var lastName = data['lastName'];
//       var serviceValue = data['service'];
//       var cityValue = data['city'];
//       var phoneValue = data['phone'];
//       var photoUrlValue = data['photoUrl'];
//       var descriptionValue = data['description'];
//       var id = data['id'];

//       setState(() {
//         name = '$firstName $lastName';
//         service = '$serviceValue';
//         city = '$cityValue';
//         phone = '$phoneValue';
//         photoUrl = '$photoUrlValue';
//         description = '$descriptionValue';
//         id = '$id';
//       });
//     }
//   }

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _serviceController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _photoUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _availabilityController = TextEditingController();

  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _loadWorkerInformation();
  }

  Future<void> _loadWorkerInformation() async {
    final workerProvider = WorkerProvider();
    final worker = await workerProvider.getWorker(widget.uid);
    setState(() {
      _worker = worker;
      _firstNameController.text = worker.firstName;
      _lastNameController.text = worker.lastName;
      _serviceController.text = worker.service;
      _cityController.text = worker.city;
      _phoneController.text = worker.phone;
      _emailController.text = worker.email;
      _photoUrlController.text = worker.photoUrl;
      _descriptionController.text = worker.description;
      _availabilityController.text = worker.availability.toString();
    });
    print(_worker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00ABB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Worker Information",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: _worker == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a first name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _serviceController,
                      decoration: const InputDecoration(labelText: 'Service'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _emailController,
                    //   decoration: const InputDecoration(labelText: 'Email'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter an email address';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _availabilityController,
                      decoration:
                          const InputDecoration(labelText: 'Availability'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter availability';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    getstart(context, "Save Changes", _saveChanges),

                    // ElevatedButton(
                    //   onPressed: () async {
                    //     _saveChanges();

                    //   },
                    //   child: const Text('Save Changes'),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final workerProvider = WorkerProvider();
      final updatedWorker = Worker(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        service: _serviceController.text,
        city: _cityController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        photoUrl: _photoUrlController.text,
        description: _descriptionController.text,
        availability:
            Map<String, String>.from(json.decode(_availabilityController.text)),
        uid: '',
      );
      await workerProvider.updateWorker(updatedWorker);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => WorkerProfilePage()),
      // );
      Navigator.pop(context, true);
    }
  }

//   void _saveChanges() async {
//     print("_saveChanges");
//   if (_formKey.currentState!.validate()) {
//     final workerProvider = WorkerProvider();

//     final updatedWorker = Worker(
//       uid: widget.uid,
//       firstName: _firstNameController.text,
//       lastName: _lastNameController.text,
//       service: _serviceController.text,
//       city: _cityController.text,
//       phone: _phoneController.text,
//       email: _emailController.text,
//       photoUrl: _photoUrlController.text,
//       description: _descriptionController.text,
//       availability: Map<String, String>.from(json.decode(_availabilityController.text)),
//     );

//     await workerProvider.updateWorker(updatedWorker);

//     setState(() {
//       _worker = updatedWorker;
//     });

//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Worker information updated successfully.'),
//       ),
//     );
//   }
// }
}
