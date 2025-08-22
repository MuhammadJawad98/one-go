import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CommonInfoScreen extends StatefulWidget {
  const CommonInfoScreen({super.key});

  @override
  State<CommonInfoScreen> createState() => _CommonInfoScreenState();
}

class _CommonInfoScreenState extends State<CommonInfoScreen> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<HomeProvider>(context, listen: false).fetchCommonInfo(context);
      // Provider.of<PaymentProvider>(context, listen: false).updateSelectedPosDeviceIp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var size = Responsive.getDynamicSize(context);
    return const Scaffold(
      body: SizedBox(),
      // body: provider.commonSettingApiStatus == ApiStatus.loading ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)):
      // provider.commonSettingApiStatus == ApiStatus.error ?
      //     Center(child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         CustomEmptyView(size: size),
      //         SizedBox(height: size.width*0.04),
      //         SizedBox(
      //           width: size.width*0.4,
      //           child: CustomButton(text: getTranslated(context, AppStrings.retry), size: size,onPressed: (){
      //             provider.fetchCommonInfo(context);
      //           },),
      //         )
      //       ],
      //     ))
      //     : Container(),
    );
  }
}
