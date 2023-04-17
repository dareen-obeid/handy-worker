import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../reusable_widgets/reusable_widget.dart';
import '../../../reusable_widgets/utils/color_utils.dart';
import '../../worker/home_worker.dart';

class BecomeWorker extends StatefulWidget {
  const BecomeWorker({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BecomeWorkerState createState() => _BecomeWorkerState();
}
    final email = FirebaseAuth.instance.currentUser!.email;

class _BecomeWorkerState extends State<BecomeWorker> {

  final TextEditingController _firstTextController = TextEditingController();
  final TextEditingController _lastTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();

  late String _selectedItem;
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseStorage.instance.ref('users/${user!.uid}/profile.jpg');
    final metadata = SettableMetadata(contentType: 'image/jpeg');

    try {
      final uploadTask = ref.putFile(_image!, metadata);
      final snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _addUserDetails() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final imageUrl = await _uploadImage();

    await FirebaseFirestore.instance.collection('workers').add({
      'firstName': _firstTextController.text,
      'lastName': _lastTextController.text,
      'email': email,
      'phone': _phoneTextController.text,
      'city': _cityTextController.text,
      'service': _selectedItem,
      'imageUrl': imageUrl ?? '',
    });
  }


  @override
  Widget build(BuildContext context) {


    List<String> services = [
      'Plumbing',
      'Painting',
      'Carpentry',
      'Electrical work',
      'House Cleaning',
      'Blacksmithing',
      'Welding',
    ];
// Create a List of DropdownMenuItem from the list of services
    List<DropdownMenuItem<String>> serviceItems = services
        .map((service) => DropdownMenuItem<String>(
              value: service,
              child: Text(
                service,
                style: const TextStyle(
                  color: Color(0xFF626262),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ))
        .toList();

// Sort the list of DropdownMenuItem alphabetically
    serviceItems.sort((a, b) => a.value!.compareTo(b.value!));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color(0xFF626262),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Become a Worker",
            style: TextStyle(
                color: Color(0xFF626262),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("FFFFFF"),
            hexStringToColor("FFFFFF")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter First Name", Icons.person_outline, false,
                  _firstTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Last Name", Icons.person_outline, false,
                  _lastTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter your City", Icons.location_city, false,
                  _cityTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "Enter your phone", Icons.phone, false, _phoneTextController),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.select_all_rounded,
                    color: const Color(0xFF848484).withOpacity(0.7),
                  ),
                  labelText: "select service",
                  labelStyle: const TextStyle(
                    color: Color(0xFF848484),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFB2B2B2).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF626262),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                iconEnabledColor: const Color(0xFF848484).withOpacity(0.7),
                items: serviceItems,
                onChanged: (String? value) {
                  _selectedItem = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              signinButton(context, false, () {
                print(_selectedItem);

                  _addUserDetails();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeWorker()));
              }),
            ]),
          )),
        ));
  }
}
