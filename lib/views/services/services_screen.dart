import 'package:car_wash_app/views/services/widets/service_card_widget.dart';
import 'package:car_wash_app/views/services/widets/service_filter_bottom_sheet.dart';
import 'package:car_wash_app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../routes/app_navigation.dart';
import '../../utils/app_assets.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).fetchServices(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SafeArea(
                  top: true,
                  bottom: false,
                  child: Row(
                    children: [
                      CustomImageButton(onTap: () => Navigator.pop(context)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: 'Services',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      CustomImageButton(
                        asset: AppAssets.filter,
                        onTap: () {
                          _showFilterBottomSheet();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: provider.isServicesLoading
                      ? Center(child: CustomLoader())
                      : provider.servicesList.isEmpty
                      ? Center(child: CustomText(text: 'No Data Found!'))
                      : GridView.builder(
                          padding: EdgeInsets.only(bottom: 50),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                          itemCount: provider.servicesList.length,
                          itemBuilder: (context, index) {
                            return ServiceCardWidget(
                              obj: provider.servicesList[index],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      builder: (context) {
        return ServiceFilterBottomSheetContent();
      },
    );
  }
}
