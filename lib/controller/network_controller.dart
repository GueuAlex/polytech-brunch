import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/connection_event_widget.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: ConnectionStateWidget(
          icon: CupertinoIcons.wifi_slash,
          text: 'Vous êtes hors ligne',
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.only(top: 2, bottom: 0),
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(
        messageText: ConnectionStateWidget(
          icon: CupertinoIcons.wifi,
          text: 'Connexion retablie',
        ),
        isDismissible: false,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.only(top: 2, bottom: 0),
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        snackStyle: SnackStyle.GROUNDED,
      );
    }
  }
}
