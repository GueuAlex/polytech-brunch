import 'package:flutter/material.dart';

import '../config/palette.dart';

class ProfilPictureContaire extends StatelessWidget {
  final double width;
  final double height;
  final String asset;
  const ProfilPictureContaire({
    super.key,
    required this.asset,
    this.height = 60,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Palette.secondaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            asset,
            //fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
