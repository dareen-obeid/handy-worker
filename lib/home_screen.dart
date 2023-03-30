
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyworker/screens/login-signup/signin_screen.dart';

class Homesreen extends StatefulWidget {
  const Homesreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomesreenState createState() => _HomesreenState();
}

class _HomesreenState extends State<Homesreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Sign out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          });
        },
      )),
    );
  }
}
