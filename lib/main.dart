import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';
import 'screens/login/login_screen.dart';
import 'utilities/app_service.dart';
import 'utilities/configs.dart';
import 'utilities/constants/core_constants.dart';
import 'utilities/firebase_options.dart';
import 'utilities/firebase_api.dart';
import 'utilities/localization/app_localization.dart';
import 'utilities/shared_preferences.dart';
import 'utilities/ui_styles.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPref.sharePrefInit();
  // if (Platform.isAndroid || Platform.isIOS) {
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   await FirebaseApi().initialFCM();
  // }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Locale? _locale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    Locale appLocale = sharedPref.getLocale();
    setState(() {
      _locale = appLocale;
    });
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
      );
    } else {
      return ScreenUtilInit(
          // designSize: const Size(428.0, 926.0),
          builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: constants.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,

          /// Localization
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: constants.supportedLocales.map((e) => e.locale),
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          // home: sharedPrefs.getUsername().isNotEmpty
          //     ? const DashboardScreen()
          //     : const LoginScreen(),
          home: const LoginScreen(),
          onGenerateRoute: onGenerateRoute,
          // routes: customRoutes,
          initialRoute: '/',
        );
      });
    }
  }
}
