import '../../../widgets/custom_text_field.dart';
import '../../../models/selection_object.dart';
import '../../../providers/my_cars_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfoStep extends StatelessWidget {
  const BasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
  builder: (context, provider, child) {
  return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          ///make model
          Row(children: [
          Expanded(child: CustomBasicInfoDropDown(title: 'Make', hintText:  provider.make?.title ?? 'Select Make', list: provider.makeList, onSelection: (val){
            provider.make = val;
            provider.model = null;
            provider.fetchModels(context, provider.make!.id);
          })),
          SizedBox(width: 8),
          Expanded(child: CustomBasicInfoDropDown(title: 'Model', hintText: provider.model?.title ?? 'Select Model', list: provider.modelList, onSelection: (val)=> provider.model = val)),
          ]),
          SizedBox(height: 16),

          ///year mileage
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Year', hintText: provider.year?.title ??'Select Year', list: provider.yearList, onSelection: (val)=> provider.year = val)),
            SizedBox(width: 8),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CustomText(text: 'Mileage',fontSize: 16,fontWeight: FontWeight.w400),
                  CustomText(text: ' *',fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.redAccentColor),
                ],),
                SizedBox(height: 10),
                RoundedTextField(
                  hintText: 'Select Mileage',
                  onChange: (val){
                    provider.mileage = val;
                  },
                )
              ],
            )
            ),
          ]),
          SizedBox(height: 16),

          ///condition regional specs
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Condition', hintText: provider.condition?.title ?? 'Select Condition', list: provider.conditionList, onSelection: (val)=> provider.condition = val)),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'Regional Specs', hintText: provider.regionSpec?.title ?? 'Select Regional Specs', list: provider.regionalSpecsList, onSelection: (val)=> provider.regionSpec = val)),
          ]),
          SizedBox(height: 16),

          ///Body type transmission
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Body Type', hintText: provider.bodyType?.title ?? 'Select Body Type', list: provider.bodyTypeList, onSelection: (val)=> provider.bodyType = val)),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'Transmission', hintText: provider.transmission?.title ?? 'Select Transmission', list: provider.transmissionList, onSelection: (val)=> provider.transmission = val)),
          ]),
          SizedBox(height: 16),

          ///fuel type color
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Fuel Type', hintText: provider.fuelType?.title ?? 'Select Fuel Type', list: provider.fuelTypeList, onSelection: (val)=> provider.fuelType = val)),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'Color', hintText: provider.color?.title ?? 'Select Color', list: provider.colorList, onSelection: (val)=> provider.color = val)),
          ]),
          SizedBox(height: 16),

          ///cylinder city
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Cylinder', hintText: provider.cylinder?.title ?? 'Select Cylinder', list: provider.cylinderList, onSelection: (val)=> provider.cylinder = val)),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'City', hintText: provider.city?.title ?? 'Select City', list: provider.cityList, onSelection: (val)=> provider.city = val)),
          ]),
          SizedBox(height: 16),

          ///variant drive type
          Row(children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Variant',fontSize: 16,fontWeight: FontWeight.w400),
                SizedBox(height: 10),
                RoundedTextField(
                  hintText: 'e.g Sports, LX, EX',
                  onChange: (val){
                    provider.variant = val;
                  },
                )
              ],
            )),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'Drive Type', hintText: provider.driveType?.title ?? 'Select Drive Type', list: provider.driveTypeList, isCompulsory: false, onSelection: (val)=> provider.driveType = val)),
          ]),
          SizedBox(height: 16),

          ///number of seats engine size
          Row(children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Number of Seats',fontSize: 16,fontWeight: FontWeight.w400),
                SizedBox(height: 10),
                RoundedTextField(
                  hintText: 'Enter number of seats',
                  onChange: (val){
                    provider.noOfSeats = val;
                  },
                )
              ],
            )),
            SizedBox(width: 8),
            Expanded(child: CustomBasicInfoDropDown(title: 'Engine Size', hintText: provider.engineSize?.title ?? 'Select Engine size', list: provider.engineSizeList, isCompulsory: false, onSelection: (val)=> provider.engineSize = val)),
          ]),
          SizedBox(height: 16),

          ///option level
          Row(children: [
            Expanded(child: CustomBasicInfoDropDown(title: 'Optional Level', hintText: provider.optionalLevel?.title ?? 'Select optional level', list: provider.optionalLevelList, isCompulsory: false, onSelection: (val)=> provider.optionalLevel = val)),
            // SizedBox(width: 16),
            // Expanded(child: SizedBox()),
          ]),
          SizedBox(height: 16),


        ],
      ),
    );
  },
);
  }
}


class CustomBasicInfoDropDown extends StatelessWidget {
  final String title;
  final String hintText;
  final List<SelectionObject> list;
  final Function(SelectionObject) onSelection;
  final bool isCompulsory;
  const CustomBasicInfoDropDown({super.key, required this.title, required this.hintText, required this.list, required this.onSelection,  this.isCompulsory = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          CustomText(text: title,fontSize: 16,fontWeight: FontWeight.w400),
         if(isCompulsory) CustomText(text: ' *',fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.redAccentColor),
        ],),
        SizedBox(height: 10),
        CustomDropDown(list: list, onSelection: onSelection, title: title,hintText: hintText),
      ],
    );
  }
}
