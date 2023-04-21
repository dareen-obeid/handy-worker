import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/worker.dart';

class WorkerFromUser extends StatefulWidget {
  final Worker worker;

  const WorkerFromUser({ Key? key, required this.worker }) : super(key: key);

  @override
  _WorkerFromUserState createState() => _WorkerFromUserState();
}


class _WorkerFromUserState extends State<WorkerFromUser> {

  late String? email;
  late String photo = "";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? ' ';
    photo =user?.photoURL ?? ' ';
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Worker Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.worker.firstName} ${widget.worker.lastName}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Service: ${widget.worker.service}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "City: ${widget.worker.city}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "Bio: ${widget.worker.description}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            // Text(
            //   "Experience: ${widget.worker.experience} years",
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
}
