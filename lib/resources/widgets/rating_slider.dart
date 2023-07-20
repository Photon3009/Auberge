import 'package:auberge/data/models/rating.dart';
import 'package:auberge/resources/colors.dart';
import 'package:auberge/resources/widgets/custom_button.dart';
import 'package:auberge/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0.0;

  void _submitRating() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    if (userId != null) {
      final rating = Rating(
        userId: userId,
        rating: _rating,
        timestamp: formattedDate,
      );

      await FirebaseFirestore.instance
          .collection('ratings')
          .add(rating.toMap());

      Utils.toastMessage('Rating submitted successfully!');
    } else {
      Utils.toastMessage('Please log in to submit a rating.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primary.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rate the food:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
            Slider(
              min: 0,
              max: 10,
              activeColor: Colors.deepOrangeAccent,
              divisions: 10,
              value: _rating,
              onChanged: (newValue) {
                setState(() {
                  _rating = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomButton(msg: 'Submit Rating', onTap: _submitRating)
          ],
        ),
      ),
    );
  }
}
