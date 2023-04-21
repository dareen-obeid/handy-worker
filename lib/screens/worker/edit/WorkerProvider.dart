import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Worker.dart';

class WorkerProvider {
  final uEmail = FirebaseAuth.instance.currentUser!.email;

  final CollectionReference _workersCollection =
      FirebaseFirestore.instance.collection('workers');

  Future<Worker> getWorker(String uid) async {
    final snapshot =
        await _workersCollection.where('email', isEqualTo: uEmail).get();
    final data = snapshot.docs[0].data() as Map<String, dynamic>;
    return Worker.fromMap(data);
  }

  Future<void> updateWorker(Worker worker) async {
    await _workersCollection.doc('ErJmqWSXQYETL14K4QG9').update(worker.toMap());
  }

  // Future<void> updateWorker(Worker worker) async {

  //   if (worker.uid == null || worker.uid.isEmpty) {
  //     // handle the case where the worker UID is empty or null
  //   }
  //   await _workersCollection.doc(worker.uid).update(worker.toMap());
  // }


}
