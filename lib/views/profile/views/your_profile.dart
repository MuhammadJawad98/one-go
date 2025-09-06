import 'package:car_wash_app/models/selection_object.dart';
import 'package:car_wash_app/models/user_model.dart';
import 'package:car_wash_app/widgets/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../providers/dashboard_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_bottom_nav_section.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import '../widgets/profile_image_widget.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  SelectionObject? gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      var provider = Provider.of<DashboardProvider>(context,listen: false);
      nameController.text = provider.userModel.name;
      phoneController.text = provider.userModel.mobile;
      emailController.text = provider.userModel.email;
      // gender = provider.genders.firstWhere((element) => element.id == provider.userModel.gender);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
  builder: (context, provider, child) {
  return CustomOverLay(
    isLoading: provider.isProfileUpdating,
    child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  children: [
                    CustomImageButton(
                      onTap: ()=> Navigator.pop(context),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Profile',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImageWidget(),
                      SizedBox(height: 16),
                      CustomText(
                        text: 'Name',
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: 6),
                      RoundedTextField(hintText: '',controller: nameController),
                      SizedBox(height: 16),
                      CustomText(
                        text: 'Phone Number',
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: 6),
                      RoundedTextField(hintText: '',controller: phoneController,enabled: false),

                      SizedBox(height: 16),
                      CustomText(
                        text: 'Email',
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: 6),
                      RoundedTextField(hintText: '',controller: emailController),

                      SizedBox(height: 16),
                      CustomText(
                        text: 'Gender',
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(height: 6),
                      Consumer<DashboardProvider>(
                        builder: (context, provider, child) {
                          return CustomDropDown(list: provider.genders,
                              onSelection: (val) {
                            gender = val;
                              },
                              title: 'Gender');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavSection(text: 'Update', onTap: () {
          UserModel obj = UserModel();
          obj.name = nameController.text;
          obj.email = emailController.text;
          obj.mobile = phoneController.text;
          obj.attachment = provider.attachment;
          Provider.of<DashboardProvider>(context,listen: false).updateProfile(context, obj);
        }),
      ),
  );
  },
);
  }
}
