class ReviewModel {
  final String name;
  final String userImage;
  final double rating;
  final String reviewText;
  final List<String> reviewImages;

  ReviewModel({
    required this.name,
    required this.userImage,
    required this.rating,
    required this.reviewText,
    required this.reviewImages,
  });
}
