import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_text.dart';
import '../../config/functions.dart';
import '../../model/scan.dart';
import '../side_bar/custom_side_bar.dart';
import '../side_bar/open_side_dar.dart';
import 'widgets/empty_scan_container.dart';
import 'widgets/home_header.dart';
import 'widgets/scan_history.dart';

class Home extends StatelessWidget {
  static String routeName = '/';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomSiderBar(),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.2),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              width: 27,
              height: 27,
            ),
            onPressed: () {
              Functions.showSnackBar(
                ctxt: context,
                messeage: 'Permettra faire des recherches dans scan historique',
              );
            },
          ),
        ],
        leading: const OpenSideBar(),
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: AppText.medium(
            'Double clic pour quitter',
            color: Colors.grey,
          ),
        ),
        child: Container(
          height: size.height,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.2),
          child: SafeArea(
            child: Stack(
              children: [
                const HomeHeader(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: size.height * 0.25),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ScanModel.scans.isEmpty
                            ? const EmptyScanContainer()
                            : const ScanHistory(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
