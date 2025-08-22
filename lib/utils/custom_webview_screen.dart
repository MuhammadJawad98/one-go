// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
//
// import '../../models/selection_object.dart';
// import '../../utils/app_colors.dart';
// import '../../widgets/custom_text.dart';
// import '../../widgets/responsive.dart';
//
// class CustomWebViewScreen extends StatefulWidget {
//   final String webUrl;
//   final String title;
//   final List<SelectionObject>? list;
//   final bool? isPdf;
//
//   const CustomWebViewScreen(
//       {super.key,
//       required this.webUrl,
//       required this.title,
//       this.list,
//       this.isPdf});
//
//   @override
//   State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
// }
//
// class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
//   late final WebViewController _controller;
//   bool load = false;
//   bool isDownloading = false;
//   final ScrollController listViewController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               load = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               load = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
//               Page resource error:
//                 code: ${error.errorCode}
//                 description: ${error.description}
//                 errorType: ${error.errorType}
//                 isForMainFrame: ${error.isForMainFrame}
//                         ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.webUrl));
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     _controller = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = Responsive.getDynamicSize(context);
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         leading: const BackButton(color: AppColors.whiteColor),
//         title: CustomText(
//           text: widget.title,
//           color: AppColors.whiteColor,
//         ),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       body: Stack(
//         children: [
//           webViewContent(),
//           if (isDownloading)
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               color: AppColors.blackColor.withAlpha(20),
//               child: Center(
//                 child: Container(
//                   padding: EdgeInsets.all(size.width * 0.1),
//                   margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: AppColors.whiteColor),
//                   child: Row(
//                     children: [
//                       const CircularProgressIndicator(
//                           color: AppColors.primaryColor),
//                       SizedBox(width: size.width * 0.04),
//                       const CustomText(text: 'Processing....')
//                     ],
//                   ),
//                 ),
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   Widget webViewContent() {
//     return Stack(
//       children: [
//         SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: WebViewWidget(controller: _controller)),
//         if (load)
//           const Center(
//               child: CircularProgressIndicator(color: AppColors.primaryColor)),
//       ],
//     );
//   }
// }
//
// class CustomScrollViewContent extends StatelessWidget {
//   const CustomScrollViewContent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//             height: 200, width: double.infinity, color: AppColors.primaryColor);
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return const SizedBox(height: 20);
//       },
//       itemCount: 10,
//     );
//   }
// }
//
// class GrabbingWidget extends StatelessWidget {
//   const GrabbingWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(blurRadius: 25, color: Colors.black.withAlpha(20)),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 20),
//             width: 100,
//             height: 7,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           // Container(
//           //   color: Colors.grey[200],
//           //   height: 2,
//           //   // margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
//           // )
//         ],
//       ),
//     );
//   }
// }
