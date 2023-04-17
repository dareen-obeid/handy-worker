import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handyworker/screens/worker/account.dart';

import '../NavigationBarItem/home_screen.dart';
import '../login-signup/signin_screen.dart';

class ProfileWorker extends StatefulWidget {
  const ProfileWorker({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileWorkerState createState() => _ProfileWorkerState();
}

class _ProfileWorkerState extends State<ProfileWorker> {
  late String? email;
  late String name = "";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? ' ';
    name = "";
    _loadData();
  }

  Future<void> _loadData() async {
    final uEmail = FirebaseAuth.instance.currentUser!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: uEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs[0].data();
      final firstName = data['first name'];
      final lastName = data['last name'];
      setState(() {
        name = '$firstName $lastName';
      });
    }
  }

//   final FirebaseFirestore _db = FirebaseFirestore.instance;

// Future<void> removeWorker(String email) async {
//   try {
//     await _db.collection('workers').doc(email).delete();
//     print('Worker with email $email has been removed');
//   } catch (e) {
//     print('Error removing worker: $e');
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/download.png'),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              email!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountWorker()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_2),
              title: const Text('retuen to normal worker'),
              onTap: () async {
                final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                final CollectionReference _workerCollection =
                    _firestore.collection('workers');

                final QuerySnapshot snapshot = await _workerCollection
                    .where('email', isEqualTo: email)
                    .get();

                if (snapshot.docs.isNotEmpty) {
                  final DocumentSnapshot doc = snapshot.docs[0];
                  await _workerCollection.doc(doc.id).delete();
                }
                print(email);
                
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Homesreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  if (kDebugMode) {
                    print("Sign out");
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
