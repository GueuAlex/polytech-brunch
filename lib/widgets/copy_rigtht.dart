import 'package:flutter/material.dart';

import '../config/app_text.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5.0),
          child: SizedBox(
            height: 18,
            //child: Image.asset('assets/images/copy_logo1.png'),
          ),
        ),
        AppText.small(
          //'Copyright © 2023 \u2022 DIGIFAZ | QR scanner \u2022 Tous droits réservés.',
          '',
          fontSize: 10,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AppText.small(
            'Developed by DIGIFAZ ®\nwww.digifaz.com',
            textAlign: TextAlign.center,
            color: Color.fromARGB(255, 225, 225, 225),
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4.0,
        )
      ],
    );
  }
}
