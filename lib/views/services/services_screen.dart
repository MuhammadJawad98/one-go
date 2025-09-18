import 'package:car_wash_app/views/services/widets/service_card_widget.dart';
import 'package:car_wash_app/views/services/widets/service_filter_bottom_sheet.dart';
import 'package:car_wash_app/widgets/custom_loader.dart';
import 'package:car_wash_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class ServicesScreen extends StatefulWidget {
  final bool isAlreadyHavingFilters;
  const ServicesScreen({super.key, this.isAlreadyHavingFilters = false});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!widget.isAlreadyHavingFilters) {
        Provider.of<DashboardProvider>(context, listen: false).fetchServices(context);
      }
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
                        onTap: () => _showFilterBottomSheet(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 Search Bar
                RoundedTextField(
                  controller: _searchController,
                  hintText: "Search services...",
                  sufixIcon: const Icon(Icons.search,color: AppColors.greyColor),
                  onChange: (val){
                      provider.filterServicesLocally(val);
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: provider.isServicesLoading
                      ? const Center(child: CustomLoader())
                      : provider.filterServicesList.isEmpty
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: 'No Data Found!'),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                          text: 'Tap to Refresh',
                          onPressed: () => provider.fetchServices(context),
                        ),
                      )
                    ],
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 50),
                    itemCount: provider.filterServicesList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return ServiceCardWidget(
                        obj: provider.filterServicesList[index],
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
      builder: (context) => ServiceFilterBottomSheetContent(),
    );
  }
}
