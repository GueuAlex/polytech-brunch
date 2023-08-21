import 'package:flutter/material.dart';
import 'package:scanner/model/my_user.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.user,
  });
  final MyUserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.elliptical(200, 10),
          bottomRight: Radius.elliptical(200, 10),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                width: 3,
                color: Palette.secondaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/profil.jpg'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AppText.large(
            '${user.nom} ${user.prenoms}',
            fontSize: 19,
            color: Colors.black.withOpacity(0.7),
          ),
          AppText.small(
            (user.isAlreadyScanned == 0 && user.heureSortieVisite == null)
                ? 'visiteur'
                : (user.isAlreadyScanned == 1 && user.heureSortieVisite == null)
                    ? 'Visiteur'
                    : 'Visite terminée',
            fontSize: 15,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
