import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("profile"),
      ),
      
    );
  }
}