import 'package:flutter/material.dart';
import 'package:scanner/config/palette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/functions.dart';
import '../../widgets/copy_rigtht.dart';
import '../scanner/scan_screen.dart';
import '../scanner/widgets/verify_by_code_sheet.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Functions.getUserListFromApi();
    Future.delayed(const Duration(seconds: 10)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        ScanSreen.routeName,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBlackColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 1),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    width: 250,
                    height: 200,
                    child: Image.asset('assets/images/brunch.png'),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    child: LoadingAnimationWidget.newtonCradle(
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ],
              ),
              const CopyRight()
            ],
          ),
        ),
      ),
    );
  }
}
