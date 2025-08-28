import 'package:flutter/material.dart';
import '../../../widgets/custom_empty_view.dart';
import '../../../models/car_detail_model.dart';
import '../../../widgets/feature_tile_widget.dart';

class CarsDetailSection extends StatelessWidget {
  final CarDetailsModel carDetailsModel;

  const CarsDetailSection({super.key, required this.carDetailsModel});

  @override
  Widget build(BuildContext context) {
    // Check if all car detail values are empty
    final bool hasNoDetails =
        carDetailsModel.makeName.isEmpty &&
        carDetailsModel.modelName.isEmpty &&
        carDetailsModel.year.isEmpty &&
        carDetailsModel.variant.isEmpty &&
        carDetailsModel.color.isEmpty &&
        carDetailsModel.conditionType.isEmpty &&
        carDetailsModel.mileage.isEmpty &&
        carDetailsModel.fuelType.isEmpty &&
        carDetailsModel.transmission.isEmpty &&
        carDetailsModel.driveType.isEmpty &&
        carDetailsModel.bodyType.isEmpty &&
        carDetailsModel.engineSize.isEmpty;

    if (hasNoDetails) {
      return const CustomEmptyView(
        title: 'No car details found',
        subtitle: 'Car details will be added soon',
        icon: Icons.directions_car_outlined,
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (carDetailsModel.makeName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.directions_car,
            title: 'Alloy Rims',
            subtitle: carDetailsModel.makeName,
            showCheckmark: false,
          ),
        if (carDetailsModel.modelName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.attach_money,
            title: 'Currently Financed',
            subtitle: carDetailsModel.modelName,
            showCheckmark: false,
          ),
        if (carDetailsModel.year.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.person,
            title: 'First Owner',
            subtitle: carDetailsModel.year,
            showCheckmark: false,
          ),
        if (carDetailsModel.variant.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.build_circle,
            title: 'Overall Condition',
            subtitle: 'Good Condition • ${carDetailsModel.variant}',
            showCheckmark: false,
          ),
        if (carDetailsModel.color.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.security,
            title: 'Air Bags Condition',
            subtitle: 'Original • ${carDetailsModel.color}',
            showCheckmark: false,
          ),
        if (carDetailsModel.conditionType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.construction,
            title: 'Chassis Condition',
            subtitle: 'Original • ${carDetailsModel.conditionType}',
            showCheckmark: false,
          ),
        if (carDetailsModel.mileage.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.engineering,
            title: 'Engine Condition',
            subtitle: 'Original • ${carDetailsModel.mileage} km',
            showCheckmark: false,
          ),
        if (carDetailsModel.fuelType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.settings,
            title: 'Gearbox Condition',
            subtitle: 'Original • ${carDetailsModel.fuelType}',
            showCheckmark: false,
          ),
        if (carDetailsModel.transmission.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.roofing,
            title: 'Roof Type',
            subtitle: 'Sunroof • ${carDetailsModel.transmission}',
            showCheckmark: false,
          ),
        if (carDetailsModel.driveType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.warning,
            title: 'Accident History',
            subtitle: 'Never • ${carDetailsModel.driveType}',
            showCheckmark: false,
          ),
        if (carDetailsModel.bodyType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.donut_large,
            title: 'Rim Size',
            subtitle: '23 inches • ${carDetailsModel.bodyType}',
            showCheckmark: false,
          ),
        if (carDetailsModel.engineSize.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.star,
            title: 'Special About Car',
            subtitle: '22" Custom Wheels • ${carDetailsModel.engineSize}',
            showCheckmark: false,
          ),
      ],
    );
  }
}

// class ReviewTile extends StatelessWidget {
//   final ReviewModel review;
//
//   const ReviewTile({super.key, required this.review});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(review.userImage),
//               radius: 20,
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   review.name,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 Row(
//                   children: List.generate(5, (i) {
//                     return Icon(
//                       i < review.rating.floor()
//                           ? Icons.star
//                           : i < review.rating
//                           ? Icons.star_half
//                           : Icons.star_border,
//                       color: Colors.amber,
//                       size: 16,
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Text(review.reviewText, style: const TextStyle(fontSize: 14)),
//         if (review.reviewImages.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: SizedBox(
//               height: 100,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: review.reviewImages.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 8),
//                 itemBuilder: (context, i) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       review.reviewImages[i],
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         width: 100,
//                         height: 100,
//                         color: Colors.grey[300],
//                         alignment: Alignment.center,
//                         child: const Icon(
//                           Icons.broken_image,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
