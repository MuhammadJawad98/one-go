import 'package:flutter/material.dart';

import '../../../models/review_model.dart';

class ReviewSection extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: reviews.length,
      separatorBuilder: (_, __) => Divider(height: 30, color: Colors.grey[300]),
      itemBuilder: (context, index) => ReviewTile(review: reviews[index]),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final ReviewModel review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(review.userImage),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < review.rating.floor()
                          ? Icons.star
                          : i < review.rating
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(review.reviewText, style: const TextStyle(fontSize: 14)),
        if (review.reviewImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.reviewImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      review.reviewImages[i],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
