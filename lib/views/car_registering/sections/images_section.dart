import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/widgets/custom_drop_down.dart';
import 'package:car_wash_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/my_cars_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Car Images :',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              CustomText(
                text:
                    'Upload high-quality images of your car from different angles. Good photos attract more buyers!',
                fontWeight: FontWeight.w400,
                color: AppColors.lightGreyTextColor,
                fontSize: 12,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 18,
                    color: AppColors.lightGreyTextColor,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text: '${provider.carImages.length} of 20 images uploaded',
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGreyTextColor,
                  ),
                ],
              ),
              SizedBox(height: 16),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => provider.pickImagesFromGallery(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.yellowAppColor.withAlpha(50),
                    border: Border.all(color: AppColors.yellowAppColor),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(
                        text: 'Click to upload your images',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: 'Max 5MB per image. JPG, PNG, WEBP allowed',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.lightGreyTextColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              ///selected images listview
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  provider.carImages[index].imageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          provider.carImages[index].imageUrl,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 100,
                                            height: 100,
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    )
                                  : provider
                                        .carImages[index]
                                        .localPath
                                        .isNotEmpty
                                  ? Image.file(
                                      File(provider.carImages[index].localPath),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Image Type',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 5),
                                  CustomDropDown(
                                    list: provider.carImageTypes,
                                    title: '',
                                    value: provider.carImages[index].imageType,
                                    onSelection: (val) {
                                      provider.updateImageType(index, val);
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  CustomText(
                                    text: 'Description',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 5),
                                  RoundedTextField(
                                    controller:
                                        provider.carImages[index].description,
                                    maxLength: 200,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: GestureDetector(
                          onTap: () => provider.removeImageFromList(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.redAccentColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: provider.carImages.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
