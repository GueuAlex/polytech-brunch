import 'package:flutter/material.dart';

import 'app_text.dart';

class Functions {
  static void showSnackBar(
      {required BuildContext ctxt, required String messeage}) {
    ScaffoldMessenger.of(ctxt).showSnackBar(
      SnackBar(
        content: AppText.medium(
          messeage,
          color: Colors.white70,
        ),
        duration: const Duration(seconds: 3),
        elevation: 5,
      ),
    );
  }

  static showBottomSheet({
    required BuildContext ctxt,
    required Widget widget,
  }) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      context: ctxt,
      builder: (context) {
        return widget;
      },
    );
  }
}
