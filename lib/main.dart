import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'config/functions.dart';
import 'dependency_injection.dart';
import 'screens/auth/login/login.dart';
import 'screens/home/home.dart';
import 'screens/scanner/scan_screen.dart';
import 'screens/scanner/widgets/verify_by_code_sheet.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      //statusBarColor: Colors.amber,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Timer? _timer;
  _timer = Timer.periodic(Duration(minutes: 1), (timer) {
    Functions.getUserListFromApi();
  });

  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      locale: const Locale('eu', 'FR'),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: "Gordita",
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      //home: const SplashScreen(),
      //home: const Home(),
      //home: const ScanSreen(),
      //initialRoute: ,
      routes: {
        '/': (ctxt) => const Home(),
        SplashScreen.routeName: (ctxt) => const SplashScreen(),
        ScanSreen.routeName: (ctxt) => const ScanSreen(),
        LoginScreen.routeName: (ctxt) => const LoginScreen(),
        VerifyByCodeSheet.routeName: (ctxt) => const VerifyByCodeSheet(),
      },
    );
  }
}
