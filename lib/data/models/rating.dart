class Rating {
  final String userId;
  final double rating;
  final String timestamp;

  Rating({
    required this.userId,
    required this.rating,
    required this.timestamp,
  });

  // Convert the Rating object to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'timestamp': timestamp,
    };
  }
}
