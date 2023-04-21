import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'edit/workerinfo.dart';

class WorkerProfilePage extends StatefulWidget {
  @override
  _WorkerProfilePageState createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? ' ';
    photo = user?.photoURL ?? ' ';
    name;
    service;
    city;
    phone;
    photoUrl;
    description;
    _loadData();
  }

  late String? email;
  late String name = "";
  late String photo = "";

  late String service = "";
  late String city = "";
  late String phone = "";
  late String photoUrl = "";
  late String description = "";
  late String uid = "";

  Future<void> _loadData() async {
    final uEmail = FirebaseAuth.instance.currentUser!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('workers')
        .where('email', isEqualTo: uEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs[0].data();
      var firstName = data['firstName'];
      var lastName = data['lastName'];
      var serviceValue = data['service'];
      var cityValue = data['city'];
      var phoneValue = data['phone'];
      var photoUrlValue = data['photoUrl'];
      var descriptionValue = data['description'];
      var uid = data['uid'];

      setState(() {
        name = '$firstName $lastName';
        service = '$serviceValue';
        city = '$cityValue';
        phone = '$phoneValue';
        photoUrl = '$photoUrlValue';
        description = '$descriptionValue';
        uid = '$uid';
      });
    }
  }

// //photo
// void pickUploadProfilePic() async {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       maxHeight: 512,
//       maxWidth: 512,
//       imageQuality: 90,
//     );

//     String uid = FirebaseAuth.instance.currentUser!.uid;
//     Reference oldRef = FirebaseStorage.instance.ref().child("https://profilepics/$uid.jpg");
//     oldRef.delete().catchError((error) => print("Error deleting previous profile picture: $error"));

//     Reference newRef = FirebaseStorage.instance
//         .ref()
//         .child("https://profilepics/$uid.jpg");

//     await newRef.putFile(File(image!.path));

//     newRef.getDownloadURL().then((value) async {
//       print(value);
//       setState(() {
//         photo = value;
//       });
//       await FirebaseAuth.instance.currentUser!.updatePhotoURL(photo);
//     });
// }

  //photo


void pickUploadProfilePic() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxHeight: 512,
    maxWidth: 512,
    imageQuality: 90,
  );

  String uid = FirebaseAuth.instance.currentUser!.uid;

  if (Platform.isIOS) {
    Reference oldRef = FirebaseStorage.instance.ref().child("https://profilepics/$uid.jpg");
    oldRef.delete().catchError((error) => print("Error deleting previous profile picture: $error"));

    Reference newRef = FirebaseStorage.instance
        .ref()
        .child("https://profilepics/$uid.jpg");

    await newRef.putFile(File(image!.path));

    newRef.getDownloadURL().then((value) async {
      print(value);
      setState(() {
        photo = value;
      });
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(photo);
    });
  } else if (Platform.isAndroid) {
    Reference oldRef = FirebaseStorage.instance.ref().child("profilepics/$uid.jpg");
    oldRef.delete().catchError((error) => print("Error deleting previous profile picture: $error"));

    Reference newRef = FirebaseStorage.instance
        .ref()
        .child("profilepics/$uid.jpg");

    await newRef.putFile(File(image!.path));

    newRef.getDownloadURL().then((value) async {
      print(value);
      setState(() {
        photo = value;
      });
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(photo);
    });
  }
}


// void pickUploadProfilePic() async {
//   final ImagePicker _picker = ImagePicker();
//   final XFile? image = await showDialog<XFile>(
//     context: context,
//     builder: (BuildContext context) {
//       return SimpleDialog(
//         title: const Text('Choose an option'),
//         children: <Widget>[
//           SimpleDialogOption(
//             onPressed: () {
//               Navigator.pop(context, _picker.pickImage(
//                 source: ImageSource.camera,
//                 maxHeight: 512,
//                 maxWidth: 512,
//                 imageQuality: 90,
//               ));
//             },
//             child: const Text('Take a new photo'),
//           ),
//           SimpleDialogOption(
//             onPressed: () {
//               Navigator.pop(context, _picker.pickImage(
//                 source: ImageSource.gallery,
//                 maxHeight: 512,
//                 maxWidth: 512,
//                 imageQuality: 90,
//               ));
//             },
//             child: const Text('Select from gallery'),
//           ),
//         ],
//       );
//     },
//   );

//   if (image == null) {
//     return;
//   }

//   Reference ref = FirebaseStorage.instance
//     .ref()
//     .child("https://profilepics/${FirebaseAuth.instance.currentUser!.uid}.jpg");

//   await ref.putFile(File(image.path));

//   ref.getDownloadURL().then((value) async {
//     print(value);
//     setState(() {
//       photo = value;
//     });
//     await FirebaseAuth.instance.currentUser!.updatePhotoURL(photo);
//   });
// }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Color(0xFF00ABB3),
        elevation: 0,
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkerInformationPage(uid: uid)),
              );
              if (result == true) {
                // refresh the page only if editing is complete
                setState(() {
                  _loadData();
                  photo;
                });
              }
            },
          ),
        ],
      ),




      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('workers')
              .where('email', isEqualTo: email)
              .snapshots(),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     GestureDetector(
  onTap: () {
    pickUploadProfilePic();
  },
  child: Stack(
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: photo == ""
              ? NetworkImage('https://www.w3schools.com/w3images/avatar2.png')
              : NetworkImage(photo),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.7),
          radius: 16,
          child: IconButton(
            icon: const Icon(Icons.edit, size: 16, color: Colors.black),
            onPressed: () {
              pickUploadProfilePic();
            },
          ),
        ),
      ),
    ],
  ),
),


//                     GestureDetector(
//   onTap: () {
//     pickUploadProfilePic();
//   },
//   child: ClipOval(
//     child: Container(
//       width: 80,
//       height: 80,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: profilePicLink == " "
//             ? NetworkImage('https://www.w3schools.com/w3images/avatar2.png')
//             : NetworkImage(profilePicLink),
//         ),
//       ),
//     ),
//   ),
// ),

// GestureDetector(
//                       onTap: () {
//                         pickUploadProfilePic();
//                       },
//                       child: Container(
//                         child: profilePicLink == " " ? const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: 80,
//                   ) : ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image.network(profilePicLink),
//                   ),
//                 ),
                      //  const CircleAvatar(
                      //   radius: 40,
                      //   backgroundImage: NetworkImage(
                      //       'https://www.w3schools.com/w3images/avatar2.png'),
                      // ),
//                     ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF00ABB3),
                                  size: 20,
                                ),
                                Text(
                                  city,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '100',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
                Text(
                  '$service Services',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'About me ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "Photos",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      15,
                      (index) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://www.w3schools.com/w3images/girl_hat.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
