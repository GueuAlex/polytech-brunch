import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/config/app_text.dart';
import 'package:scanner/config/palette.dart';
import 'package:scanner/widgets/all_sheet_header.dart';
import 'package:scanner/widgets/custom_button.dart';

class ErrorSheetContainer extends StatelessWidget {
  const ErrorSheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const AllSheetHeader(),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(200, 10),
                bottomRight: Radius.elliptical(200, 10),
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(CupertinoIcons.xmark, size: 30),
                ),
              ),
            ),
          ),
          AppText.medium('QR code invalide !'),
          //AppText.small('Veu')
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 50,
              left: 50,
            ),
            child: CustomButton(
              color: Palette.appBlackColor,
              width: double.infinity,
              height: 35,
              radius: 5,
              text: 'Retour',
              onPress: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
