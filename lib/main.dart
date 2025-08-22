import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../services/local_notification_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_providers.dart';
import '../utils/application_shared_instance.dart';
import '../utils/print_log.dart';
import '../views/splash_screen.dart';
import 'firebase_options.dart';
import 'localization/localization_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.initialize();
  LocalNotificationService.onNotificationClick = (payload) {
    // Navigate or perform action with payload
    PrintLogs.printLog('Notification clicked with payload: $payload');
  };
  LocalNotificationService.configureFirebaseMessagingHandlers();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(providers: appProviders, child: const MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      Provider.of<DashboardProvider>(context,listen: false).getAppVersion();
    });
  }

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: "BDN Fitness",
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: AppColors.whiteColor,
            fontFamily: Provider.of<LanguageProvider>(context).selectedIndex == 1 ? 'ArbFONTS': 'Poppins',
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            })),
        // home: const SplashScreen(),
        navigatorKey: NavigationService.navigatorKey,
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashScreen(),
        supportedLocales: DataManager().languageList,
        locale: Provider.of<LanguageProvider>(context).appLanguage,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}


class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
