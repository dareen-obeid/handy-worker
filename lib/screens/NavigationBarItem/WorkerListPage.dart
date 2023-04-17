import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/worker.dart';

class WorkerListPage extends StatefulWidget {
  final String service;

  const WorkerListPage({Key? key, required this.service}) : super(key: key);

  @override
  _WorkerListPageState createState() => _WorkerListPageState();
}

class _WorkerListPageState extends State<WorkerListPage> {
  List<Worker>? workers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    // Retrieve the list of workers from Firebase based on the selected service
    FirebaseFirestore.instance
        .collection('workers')
        .where('service', isEqualTo: widget.service)
        .get()
        .then((snapshot) {
      setState(() {
        workers = snapshot.docs.map((doc) => Worker.fromSnapshot(doc)).toList();
        isLoading = false; // set isLoading to false when the data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service),
      ),
      body: ListView.builder(
        itemCount: workers!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(workers![index].firstName),
            subtitle: Text(workers![index].city),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to the worker details screen
              print(workers![index].firstName);
              print(workers![index].city);
            },
          );
        },
      ),
    );
  }
}
