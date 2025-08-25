import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class ProfileImageWidget extends StatefulWidget {
  final bool fromProfile;
  const ProfileImageWidget({super.key,this.fromProfile= false});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Center(
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.fieldBgColor,
                ),
                child: provider.userModel.profilePictureUrl.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: provider.userModel.profilePictureUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                )
                    : Image.asset(AppAssets.person),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    _pickImage(context);
                  },
                  child: Image.asset(
                    AppAssets.profileEdit,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        bool isDarkMode = false;
        var contxt = NavigationService.navigatorKey.currentState!.context;
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading:
                Icon(Icons.camera_alt, color: isDarkMode ? AppColors.whiteColor : AppColors.primaryColor),
                title: CustomText(text: 'Take Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    final file = File(pickedFile.path);
                    Provider.of<DashboardProvider>(contxt, listen: false).uploadUserPic(contxt, file,fromProfile: widget.fromProfile);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: isDarkMode ? AppColors.whiteColor : AppColors.primaryColor),
                title: CustomText(text: 'Choose From Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    final file = File(pickedFile.path);
                    Provider.of<DashboardProvider>(contxt, listen: false).uploadUserPic(contxt, file,fromProfile: widget.fromProfile);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
