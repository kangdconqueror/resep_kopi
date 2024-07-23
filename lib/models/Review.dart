class Review {
  final String reviewer;
  final String review;
  final String timestamp;

  Review({
    required this.reviewer,
    required this.review,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'reviewer': reviewer,
        'review': review,
        'timestamp': timestamp,
      };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewer: json['reviewer'],
        review: json['review'],
        timestamp: json['timestamp'],
      );
}
