import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../model/side_bar_item.dart';
import '../../scanner/scan_screen.dart';

class EmptyScanContainer extends StatelessWidget {
  const EmptyScanContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText.small(
              'Vous trouverez ici  l\'historique des scans une fois quelques scans enregistrés !',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            /*  AudioCache player = AudioCache();
            player.play('images/soung.mp3'); */
            SideBarItemModel.selectedIndex = 1;
            Navigator.of(context).pushNamedAndRemoveUntil(
              ScanSreen.routeName,
              (route) => false,
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Palette.primaryColor,
            ),
          ),
          child: AppText.medium(
            'Faire un scan',
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
