import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_text.dart';
import '../../../model/scan.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset('assets/icons/qr.svg'),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          AppText.small('Total des scans'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppText.large(
                ScanModel.scans.length.toString(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
