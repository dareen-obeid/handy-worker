import 'package:cloud_firestore/cloud_firestore.dart';

import 'Review.dart';

class ReviewsService {
  final CollectionReference reviewsCollection =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> addReview(String workerId, String userId, String text,
      double rating, DateTime timestamp) async {
    await reviewsCollection.add({
      'workerId': workerId,
      'userId': userId,
      'text': text,
      'rating': rating,
      'timestamp': timestamp,
    });
  }

  Stream<List<Review>> getReviewsForWorker(String workerId) {
    return reviewsCollection
        .where('workerId', isEqualTo: workerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Review(
                  id: doc.id,
                  userId: doc['userId'],
                  workerId: doc['workerId'],
                  text: doc['text'],
                  rating: doc['rating'],
                  timestamp: doc['timestamp'].toDate(),
                ))
            .toList());
  }
}