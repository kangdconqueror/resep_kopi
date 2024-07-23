import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/review.dart';

class ReviewPage extends StatefulWidget {
  final String? coffeeName;

  ReviewPage({this.coffeeName});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _reviewController = TextEditingController();
  final _nameController = TextEditingController();

  void _submitReview() async {
    final name = _nameController.text;
    final review = _reviewController.text;
    final timestamp = DateTime.now().toString();

    if (name.isEmpty || review.isEmpty) return;

    final reviewData = Review(
      reviewer: name,
      review: review,
      timestamp: timestamp,
    );

    final prefs = await SharedPreferences.getInstance();
    final key = widget.coffeeName != null ? 'reviews_${widget.coffeeName!}' : 'reviews_all';
    final savedReviews = prefs.getStringList(key) ?? [];
    savedReviews.add(jsonEncode(reviewData.toJson()));
    await prefs.setStringList(key, savedReviews);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review berhasil ditambahkan!')),
    );

    _reviewController.clear();
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffeeName != null ? 'Review ${widget.coffeeName}' : 'Tulis Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.coffeeName != null)
              Text(
                'Review untuk ${widget.coffeeName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(labelText: 'Review'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Kirim Review'),
            ),
          ],
        ),
      ),
    );
  }
}
