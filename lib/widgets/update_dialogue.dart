// import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart';
// import '../localization/language_constraints.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_strings.dart';
// import '../widgets/responsive.dart';
// import 'custom_text.dart';
//
// void showUpdateDialogue(BuildContext context, AppInfo appInfo) {
//   var size = Responsive.getDynamicSize(context);
//   showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) => PopScope(
//         canPop: false,
//         child: AlertDialog(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(30.0))),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Lottie.asset(LottieAssets.warningLottie,
//               //     width: size.width * 0.4,
//               //     height: size.width * 0.4,
//               //     fit: BoxFit.fitHeight,
//               //     repeat: true),
//               SizedBox(height: size.width * 0.02),
//               CustomText(
//                   text: getTranslated(context, AppStrings.newVersionAvailable),
//                   textAlign: TextAlign.center,
//                   fontWeight: FontWeight.w600,
//                   fontSize: size.width * 0.05),
//               SizedBox(height: size.width * 0.02),
//               CustomText(
//                   text: getTranslated(context, AppStrings.pleaseUpdateAppText),
//                   textAlign: TextAlign.center,
//                   fontSize: size.width * 0.035,
//                   textColor: AppColors.primaryColor,
//                   fontWeight: FontWeight.w400),
//               SizedBox(height: size.width * 0.04),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Material(
//                   borderRadius: BorderRadius.circular(30),
//                   color: AppColors.primaryColor,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(30),
//                     onTap: () {
//                       StoreRedirect.redirect(
//                           androidAppId: appInfo.androidUrl,
//                           iOSAppId: appInfo.iosUrl);
//                     },
//                     child: Container(
//                         padding: EdgeInsets.all(size.width * 0.02),
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//                         child: CustomText(
//                           text: getTranslated(context, AppStrings.updateNow),
//                           textColor: AppColors.whiteColor,
//                           fontSize: size.width * 0.03,
//                         )),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )),
//   );
// }
