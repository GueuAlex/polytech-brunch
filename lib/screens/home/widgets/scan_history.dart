import 'package:flutter/material.dart';

import '../../../model/scan.dart';
import 'scan_container.dart';

class ScanHistory extends StatelessWidget {
  const ScanHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            ScanModel.scans.length,
            (index) => ScanContainer(
              scan: ScanModel.scans[index],
            ),
          ),
        ),
      ),
    );
  }
}
