import 'package:car_wash_app/providers/car_listing_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/language_provider.dart';
import '../providers/orders_provider.dart';
import '../providers/theme_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()),
  ChangeNotifierProvider<DashboardProvider>(create: (context) => DashboardProvider()),
  ChangeNotifierProvider<OrdersProvider>(create: (context) => OrdersProvider()),
  ChangeNotifierProvider<CarListingProvider>(create: (context) => CarListingProvider()),
  // ChangeNotifierProvider<ProgressProvider>(create: (context) => ProgressProvider()),
  ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
  // ChangeNotifierProvider<TrainingProgramProvider>(create: (context) => TrainingProgramProvider()),
  // ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
];
