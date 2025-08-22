// import 'package:flutter/material.dart';
//
// import '../views/auth/login_screen.dart';
// import '../views/home/home_screen.dart';
// import '../views/splash_screen.dart';
//
// class AppRoutes {
//   static const splashScreen  =  "/";
//   static const loginScreen = "/loginScreen";
//   static const otpScreen = "/otpScreen";
//   static const homeScreen = "/homeScreen";
//   static const attendanceScreen = "/attendanceScreen";
//   static const timeOffScreen = "/timeOffScreen";
//   static const dashboardScreen = "/dashboardScreen";
//   static const expenseScreen = "/expenseScreen";
//   static const accountScreen = "/accountScreen";
//
// }
//
// Map<String, Widget Function(BuildContext)> appRoutes = {
//   AppRoutes.splashScreen: (context) => const SplashScreen(),
//   AppRoutes.loginScreen: (context) => const LoginScreen(),
//   AppRoutes.homeScreen: (context) => const HomeScreen(),
//   AppRoutes.attendanceScreen: (context) =>  Container(),
//   AppRoutes.dashboardScreen: (context) =>   Container(),
//   AppRoutes.timeOffScreen: (context) =>   Container(),
//   AppRoutes.expenseScreen: (context) =>   Container(),
//   AppRoutes.accountScreen: (context) =>   Container(),
//
// };
//
// Widget buildHomeNavigator(BuildContext context, String route) {
//   return Navigator(
//     onGenerateRoute: (settings) {
//       return MaterialPageRoute(
//         fullscreenDialog: true,
//         settings: settings,
//         builder: (context) {
//           return appRoutes[route]!(context);
//         },
//       );
//     },
//   );
// }
