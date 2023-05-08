import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyworker/screens/NavigationBarItem/home/WorkerViewFromUser.dart';
import '../../../models/worker.dart';

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
        backgroundColor: Color(0xFF00ABB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.service,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: workers!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkerFromUser(worker: workers![index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: workers![index].photoUrl != null &&
                              workers![index].photoUrl.isNotEmpty &&
                              Uri.parse(workers![index].photoUrl).isAbsolute
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                workers![index].photoUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.network(
                              'https://www.w3schools.com/w3images/avatar2.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workers![index].firstName} ${workers![index].lastName}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            workers![index].city,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
