import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handyworker/screens/NavigationBarItem/home/reviews/Review.dart';
import 'package:handyworker/screens/NavigationBarItem/home/reviews/ReviewsService.dart';
import '../../../models/worker.dart';

class WorkerFromUser extends StatefulWidget {
  final Worker worker;

  const WorkerFromUser({ Key? key, required this.worker }) : super(key: key);

  @override
  _WorkerFromUserState createState() => _WorkerFromUserState();
}


class _WorkerFromUserState extends State<WorkerFromUser> {
final ReviewsService _reviewsService = ReviewsService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _reviewTextController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.worker.firstName+" "+ widget.worker.lastName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.worker.photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Rating: ${widget.worker.rating}',
                //   style: TextStyle(fontSize: 18),
                // ),
                // SizedBox(height: 8),
                // Text(
                //   'Number of reviews: ${widget.worker.numReviews}',
                //   style: TextStyle(fontSize: 18),
                // ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Review>>(
              stream: _reviewsService.getReviewsForWorker(widget.worker.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading reviews'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Review> reviews = snapshot.data!;

                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    Review review = reviews[index];

                    return ListTile(
                      title: Text(review.text),
                      subtitle: Text(
                          '${review.rating} stars by ${review.userId} on ${review.timestamp}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add your review',
                  style: TextStyle(fontSize: 18),
                ),
               SizedBox(height: 8),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 24,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _reviewTextController,
                        decoration: InputDecoration(
                          hintText: 'Enter your review',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    User? user = _auth.currentUser;

                    if (user == null) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      await _reviewsService.addReview(
                        widget.worker.id,
                        user.uid,
                        _reviewTextController.text,
                        _rating,
                        DateTime.now(),
                      );

                      _reviewTextController.clear();

                      setState(() {
                        _rating = 0;
                      });
                    }
                  },
                  child: Text('Submit review'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}