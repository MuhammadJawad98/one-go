import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/review_model.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../widgets/custom_text.dart';

class CarsDetailSection extends StatelessWidget {
  final List<ReviewModel> reviews;

  const CarsDetailSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            customItem("Alloy Rims", provider.carDetailsModel.makeName),
            customItem("Currently Financed", provider.carDetailsModel.modelName),
            customItem("First Owner", provider.carDetailsModel.year),
            customItem("Overall Condition: Good Condition", provider.carDetailsModel.variant),
            customItem("Air Bags Condition: Original", provider.carDetailsModel.color),
            customItem("Chassis Condition: Original", provider.carDetailsModel.conditionType),
            customItem("Engine Condition: Original", provider.carDetailsModel.mileage),
            customItem("Gearbox Condition: Original", provider.carDetailsModel.fuelType),
            customItem("Roof Type: Sunroof", provider.carDetailsModel.transmission),
            customItem("Accident History: Never", provider.carDetailsModel.driveType),
            customItem("Rim Size: 23", provider.carDetailsModel.bodyType),
            customItem("Special About Car: 22", provider.carDetailsModel.engineSize),
          ],
        );
      },
    );
  }

  Widget customItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              text: '$title:',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomText(text: value, fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
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
