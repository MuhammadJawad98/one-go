import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../models/selection_object.dart';
import '../../widgets/custom_overlay.dart';
import '../../providers/my_cars_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_text.dart';
import '../../views/car_registering/sections/basic_info_section.dart';
import '../../views/car_registering/sections/details_section.dart';
import '../../views/car_registering/sections/features_section.dart';
import '../../views/car_registering/sections/images_section.dart';
import '../../widgets/custom_button.dart';
import 'sections/pricing_section.dart';
import 'package:flutter/material.dart';

class CreateCarScreen extends StatefulWidget {
  final String? id;
  const CreateCarScreen({super.key, this.id});

  @override
  State<CreateCarScreen> createState() => _CreateCarScreenState();
}

class _CreateCarScreenState extends State<CreateCarScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<String> _steps = [
    "Basic Info",
    "Details",
    "Features",
    "Images",
    "Pricing",
  ];
  final List<SelectionObject> notesList = [
    SelectionObject(
      title: 'Note: ',
      value:
          'All fields marked with * are required. Make sure all information is accurate as it will be displayed to potential buyers.',
    ),
    SelectionObject(
      title: 'Tip: ',
      value:
          'Being honest about your car\'s condition helps build trust with potential buyers and leads to better offers.',
    ),
    SelectionObject(
      title: 'Note: ',
      value:
          'Only select features that are actually present and working in your car. Accurate feature information helps buyers make informed decisions and builds trust.',
    ),
    SelectionObject(
      title: 'Photo Guidelines',
      value: 'Upload clear, well-lit photos (min 800x600px) of all angles & interior; show damage; max 5MB; JPG/PNG/WebP only.',
    ),
    SelectionObject(
      title: 'Note: ',
      value:
          'Your listing won\'t be visible to buyers until you submit it for review and it gets approved.',
    ),
  ];

  void _nextStep() async{
    // var provider = Provider.of<MyCarsProvider>(context,listen: false);
    if (_currentStep < _steps.length - 1) {
      // if(_currentStep == 1){
      //   provider.initFeatureList();
      // }

      if(_currentStep == 0){
        var result = await Provider.of<MyCarsProvider>(context,listen: false).postCarBasic();
        if(result == null || result == false) return;
      }else if(_currentStep == 1){
        var result = await Provider.of<MyCarsProvider>(context,listen: false).postCarDetail();
        if(result == null || result == false) return;
      }else if(_currentStep == 2){
        var result = await Provider.of<MyCarsProvider>(context,listen: false).postCarFeatures();
        if(result == null || result == false) return;
      }else if(_currentStep == 3){
        var result = await Provider.of<MyCarsProvider>(context,listen: false).postCarDocuments(context);
        if(result == null || result == false) return;
      }
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }else if(_currentStep == 4){
      Provider.of<MyCarsProvider>(context,listen: false).postCarPricing(context);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(widget.id!=null){
        context.read<MyCarsProvider>().onEditCar(context, widget.id!);
      }else{
        context.read<MyCarsProvider>().init(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
  builder: (context, provider, child) {
  return CustomOverLay(
      isLoading: provider.isLoading,
      child: Scaffold(
        appBar: AppBar(title: CustomText(text: "Add New Car"), centerTitle: true),
        body: Column(
          children: [
            // Step indicators
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: _steps[_currentStep],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: 'Step ${_currentStep + 1} of 5',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
      
                  SizedBox(height: 10),
      
                  Row(
                    children: List.generate(
                      _steps.length,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 6,
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.yellowAppColor.withAlpha(50),
                border: Border.all(color: AppColors.yellowAppColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info, color: Colors.black87, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: notesList[_currentStep].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: notesList[_currentStep].value),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            // PageView for steps
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BasicInfoStep(),
                  DetailsStep(),
                  FeaturesSection(),
                  ImagesSection(),
                  PricingSection(),
                ],
              ),
            ),
      
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                bottom: Platform.isIOS ? false : true,
                left: false,
                top: false,
                right: false,
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: CustomButton(
                          text: 'Back',
                          backgroundColor: AppColors.primaryColor.withAlpha(50),
                          textColor: AppColors.primaryColor,
                          borderRadius: 12,
                          hasBorder: true,
                          borderColor: AppColors.primaryColor,
                          onPressed: _previousStep,
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: _currentStep == _steps.length - 1 ? 'Finish':'Next',
                        borderRadius: 12,
                        onPressed: _nextStep,
                      ),
                    ),
                  ],
                ),
              ),
              // child: Row(
              //   children: [
              //     if (_currentStep > 0)
              //       ElevatedButton(
              //         onPressed: _previousStep,
              //         child: const Text("Back"),
              //       ),
              //     const Spacer(),
              //     ElevatedButton(
              //       onPressed: _nextStep,
              //       child: Text(
              //         _currentStep == _steps.length - 1 ? "Submit" : "Next",
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
