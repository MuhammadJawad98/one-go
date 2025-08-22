import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../../models/selection_object.dart';
import '../../utils/app_colors.dart';
import '../../utils/print_log.dart';
import '../localization/language_constraints.dart';
import '../utils/app_strings.dart';
import '../utils/helper_functions.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class CustomDropDown extends StatefulWidget {
  final String title;
  final String? hintText;
  final List<SelectionObject> list;
  final Function(SelectionObject) onSelection;
  final SelectionObject? value;

  const CustomDropDown(
      {super.key,
      required this.list,
      required this.onSelection,
      required this.title,
      this.hintText, this.value});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final _tfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setInitialValue();
  }

  @override
  void didUpdateWidget(covariant CustomDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setInitialValue(); // update text when parent changes value
  }

  void _setInitialValue() {
    if (widget.value != null) {
      _tfController.text = HelperFunctions.capitalizeFirstLetter(widget.value!.title);
    } else {
      _tfController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RoundedTextField(
        controller: _tfController,
        hintText: widget.hintText ?? getTranslated(context, AppStrings.selectAnOption),
        enabled: false,
        hintStyle: const TextStyle(color: AppColors.primaryColor),
        textStyle: const TextStyle(color: AppColors.primaryColor),
        sufixIcon: const Icon(Icons.arrow_drop_down),
      ),
      onTap: () async {
        showCustomBottomSheet(context, widget.list, onSelection: (result) {
          PrintLogs.printLog("result: $result");
          _tfController.text = HelperFunctions.capitalizeFirstLetter(result.title);
          widget.onSelection(result);
        });
      },
    );
  }

  Future<dynamic> showCustomBottomSheet(
      BuildContext context, List<SelectionObject> list,
      {required Function(SelectionObject) onSelection}) async {
    var size = Responsive.getDynamicSize(context);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: Container(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: widget.title,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500),
                        const CloseButton(),
                      ]),
                  // SizedBox(height: size.width * 0.02),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: list.length, // Number of items
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: size.width * 0.02);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CustomLanTile(
                              title: HelperFunctions.capitalizeFirstLetter(
                                  list[index].title),
                              onTap: () {
                                onSelection(list[index]);
                                Navigator.pop(context);
                              },
                              size: size);
                        }),
                  )
                ],
              )),
        );
      },
    );
  }
}

class CustomLanTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Size size;
  final bool isArabic;

  const CustomLanTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.size,
      this.isArabic = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.0),
      color: AppColors.whiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.greyColor.withAlpha(80))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: title,
                  fontSize: size.width * 0.04,
                  fontFamily: isArabic ? 'ArbFONTS' : null),
              Icon(
                Icons.arrow_forward_ios,
                size: size.width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
