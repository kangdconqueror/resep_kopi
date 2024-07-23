import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/review.dart';

class AllReviewsPage extends StatefulWidget {
  @override
  _AllReviewsPageState createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  final List<Review> _allReviews = [];

  @override
  void initState() {
    super.initState();
    _loadAllReviews();
  }

  Future<void> _loadAllReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final reviews = <Review>[];

    for (var key in keys) {
      if (key.startsWith('reviews_')) {
        final savedReviews = prefs.getStringList(key) ?? [];
        reviews.addAll(savedReviews.map((e) => Review.fromJson(jsonDecode(e))).toList());
      }
    }

    setState(() {
      _allReviews.addAll(reviews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _allReviews.length,
          itemBuilder: (context, index) {
            final review = _allReviews[index];
            return ListTile(
              title: Text(review.review),
              subtitle: Text('oleh ${review.reviewer} pada ${review.timestamp}'),
            );
          },
        ),
      ),
    );
  }
}
