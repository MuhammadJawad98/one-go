// import 'package:flutter/material.dart';
//
// class ProductGallerySection extends StatelessWidget {
//   final List<String> galleryImages;
//
//   const ProductGallerySection({super.key, required this.galleryImages});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ImageGalleryGrid(imageUrls: galleryImages),
//     );
//   }
// }
//
// class ImageGalleryGrid extends StatelessWidget {
//   final List<String> imageUrls;
//
//   const ImageGalleryGrid({super.key, required this.imageUrls});
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemCount: imageUrls.length,
//       padding: EdgeInsets.zero,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.network(
//             imageUrls[index],
//             fit: BoxFit.cover,
//             loadingBuilder: (context, child, progress) => progress == null
//                 ? child
//                 : const Center(child: CircularProgressIndicator()),
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: Colors.grey[300],
//               alignment: Alignment.center,
//               child: const Icon(
//                 Icons.broken_image,
//                 size: 40,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
