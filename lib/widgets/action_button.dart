import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/palette.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.child,
    required this.isOn,
  });

  final String child;
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.2),
        shape: BoxShape.circle,
        // boxShadow: [],
      ),
      child: Center(
        child: SvgPicture.asset(
          child,
          color: isOn ? Palette.appPrimaryColor : Palette.primaryColor,
        ),
      ),
    );
  }
}
