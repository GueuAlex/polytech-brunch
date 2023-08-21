import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../model/scan.dart';
import '../../../widgets/profil_picture_container.dart';

class ScanContainer extends StatelessWidget {
  final ScanModel scan;
  const ScanContainer({
    super.key,
    required this.scan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        ListTile(
          onTap: () => Functions.showSnackBar(
            ctxt: context,
            messeage: 'permettra d\'affichier les infos relatif à ce scan',
          ),
          leading:
              const ProfilPictureContaire(asset: 'assets/images/profil.jpg'),
          title: AppText.medium('${scan.data.nom} ${scan.data.prenoms}'),
          subtitle: scan.data.heureSortieVisite == null
              ? AppText.small('Visite en cours')
              : AppText.small('Visite terminée'),
          trailing: const Icon(
            CupertinoIcons.chevron_right,
          ),
        ),
        //AppText.medium('data')
      ],
    );
  }
}
