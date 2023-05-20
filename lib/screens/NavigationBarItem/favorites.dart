import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/worker.dart';
import 'home/WorkerViewFromUser.dart';

class FavPage extends StatefulWidget {
  final String userId;

  const FavPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  List<Worker> workers = [];
  bool isLoading = true;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('favorites')
          .get();

      final favoriteWorkerIds = favoritesSnapshot.docs.map((doc) => doc.id).toList();

      if (favoriteWorkerIds.isNotEmpty) {
        final snapshot = await FirebaseFirestore.instance
            .collection('workers')
            .where('id', whereIn: favoriteWorkerIds)
            .get();

        setState(() {
          workers = snapshot.docs.map((doc) => Worker.fromSnapshot(doc)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          workers = [];
          isLoading = false;
        });
      }
    } catch (error) {
      // Handle error here
      print(error.toString());
    }
  }

  Future<void> removeFromFavorites(String workerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('favorites')
          .doc(workerId)
          .delete();

      setState(() {
        workers.removeWhere((worker) => worker.id == workerId);
      });
    } catch (error) {
      // Handle error here
      print(error.toString());
    }
  }

  bool isFavorite(String workerId) {
    return workers.any((worker) => worker.id == workerId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00ABB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorite Workers',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (BuildContext context, int index) {
          final worker = workers[index];
          final isFavoriteWorker = isFavorite(worker.id);

          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkerFromUser(worker: worker),
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
                      child: worker.photoUrl != null &&
                              worker.photoUrl.isNotEmpty &&
                              Uri.parse(worker.photoUrl).isAbsolute
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                worker.photoUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.network(
                              'https://www.w3schools.com/w3images/avatar2.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${worker.firstName} ${worker.lastName}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            worker.city,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavoriteWorker ? Icons.favorite : Icons.favorite_border,
                        color: isFavoriteWorker ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavoriteWorker) {
                            removeFromFavorites(worker.id);
                          }
                        });
                      },
                    ),
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
