import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../providers/car_listing_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/language_provider.dart';
import '../providers/my_cars_provider.dart';
import '../providers/orders_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';


List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()),
  ChangeNotifierProvider<DashboardProvider>(create: (context) => DashboardProvider()),
  ChangeNotifierProvider<OrdersProvider>(create: (context) => OrdersProvider()),
  ChangeNotifierProvider<CarListingProvider>(create: (context) => CarListingProvider()),
  ChangeNotifierProvider<MyCarsProvider>(create: (context) => MyCarsProvider()),
  ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
  // ChangeNotifierProvider<TrainingProgramProvider>(create: (context) => TrainingProgramProvider()),
  // ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
];
