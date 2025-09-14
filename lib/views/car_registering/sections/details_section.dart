import 'package:car_wash_app/providers/my_cars_provider.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_drop_down.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsStep extends StatefulWidget {
  const DetailsStep({super.key});

  @override
  State<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<DetailsStep> {
  var descriptionTF = TextEditingController();
  var accidentDetailTF = TextEditingController();
  var rimeSizeTF = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
  builder: (context, provider, child) {
  return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      CustomText(text: 'Car Details & Condition :',fontWeight: FontWeight.w600,fontSize: 16),
      CustomText(text: 'Provide detailed information about your car\'s condition and history.',fontWeight: FontWeight.w400,color: AppColors.lightGreyTextColor,fontSize: 12),
      SizedBox(height: 16),

      CustomText(text: 'Overall Condition',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.overAllConditionList, title: 'Select an option',value: provider.overAllCondition, onSelection: (val)=> provider.overAllCondition = val),

      SizedBox(height: 8),
      CustomText(text: 'Accident History',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.accidentHistoryList, title: 'Select an option',value: provider.accidentHistory, onSelection: (val){
        setState(() {
          provider.accidentHistory = val;
        });
      }),
      if(provider.accidentHistory!=null && provider.accidentHistory?.value != 'never')...[
        SizedBox(height: 8),
        CustomText(text: 'Accident Details *',fontWeight: FontWeight.w600),
        SizedBox(height: 8),
        RoundedTextField(
          hintText: 'Please provide details about the accident and repair done...',
          maxLines: 5,
          controller: accidentDetailTF,
          onChange: (val){
            provider.accidentDetails = accidentDetailTF.text.trim();
          }
        ),
        SizedBox(height: 5),
        CustomText(text: '0/500 characters.',fontSize: 12),
      ],

      //component
      SizedBox(height: 16),
      CustomText(text: 'Component :',fontWeight: FontWeight.w600,fontSize: 16),
      SizedBox(height: 16),

      SizedBox(height: 8),
      CustomText(text: 'Air Bags Condition',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.airBagsConditionList, title: 'Select an option',value: provider.airBagsCondition, onSelection: (val)=> provider.airBagsCondition = val),

      SizedBox(height: 8),
      CustomText(text: 'Chassis Condition',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.chassisConditionList, title: 'Select an option',value: provider.chassisCondition, onSelection: (val)=> provider.chassisCondition = val),

      SizedBox(height: 8),
      CustomText(text: 'Engine Condition',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.engineConditionList, title: 'Select an option',value: provider.engineCondition, onSelection: (val)=> provider.engineCondition = val),

      SizedBox(height: 8),
      CustomText(text: 'Gear Box Condition',fontWeight: FontWeight.w600),
      SizedBox(height: 8),
      CustomDropDown(list: provider.gearBoxConditionList, title: 'Select an option',value: provider.gearBoxCondition, onSelection: (val)=> provider.gearBoxCondition = val),


      //Wheels & Exterior
      SizedBox(height: 16),
      CustomText(text: 'Wheels & Exterior :',fontWeight: FontWeight.w600,fontSize: 16),
      SizedBox(height: 16),

      CheckboxListTile(
          value: provider.hasAlloyRims,
          activeColor: AppColors.primaryColor,
          title: CustomText(text: 'Has Alloy Rims',fontWeight: FontWeight.w600),
          onChanged: (val){
            provider.updateHasRim(val!);
          }),
          if(provider.hasAlloyRims)...[
                RoundedTextField(
                  hintText: 'e.g, 18',
                  controller: rimeSizeTF,
                  keyboardType: TextInputType.number,
                  onEditDone: (){
                    provider.rimSize = rimeSizeTF.text.trim();
                  },
                ),
          ],


      SizedBox(height: 8),
      CustomText(text: 'Roof Type',fontWeight: FontWeight.w500),
      SizedBox(height: 8),
      CustomDropDown(list: provider.roofTypeList, title: 'Select an option',value: provider.roofType, onSelection: (val)=> provider.roofType = val),

      //Financial & Ownership
      SizedBox(height: 16),
      CustomText(text: 'Wheels & Exterior :',fontWeight: FontWeight.w600,fontSize: 16),
      SizedBox(height: 16),

      CheckboxListTile(
           value: provider.currentlyFinanced,
           activeColor: AppColors.primaryColor,
           title: CustomText(text: 'Currently Financed',fontWeight: FontWeight.w500),
           onChanged: (val){
              provider.updateCurrentlyFinanced(val!);
           }),

      CheckboxListTile(
           value: provider.firstOwner,
           activeColor: AppColors.primaryColor,
           title: CustomText(text: 'I am the First Owner',fontWeight: FontWeight.w500),
           onChanged: (val){
             provider.updateFirstOwner(val!);
           }),


              SizedBox(height: 16),
              CustomText(text: 'What\'s Special About This Car? (Optional)',fontWeight: FontWeight.w600,fontSize: 16),
              SizedBox(height: 16),
              RoundedTextField(
                hintText: 'Describe any special features, modification, recent maintenance, or unique aspects',
                maxLines: 5,
                controller: descriptionTF,
                onChange: (val){
                  provider.specialAboutCar = descriptionTF.text.trim();
                },
              ),
              SizedBox(height: 5),
              CustomText(text: '0/1000 characters. This will be displayed to potential buyers.',fontSize: 12),

            ]));
  },
);
  }
}
