import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../widgets/custom_button.dart';
import 'infos_column.dart';
import 'sheet_container.dart';

class VerifyByCodeSheet extends StatefulWidget {
  static const routeName = 'verifyByCodeSheet';
  const VerifyByCodeSheet({
    super.key,
  });

  @override
  State<VerifyByCodeSheet> createState() => _VerifyByCodeSheetState();
}

class _VerifyByCodeSheetState extends State<VerifyByCodeSheet> {
  ////////////////
  ///
  AudioCache player = AudioCache();
  ///////////////:
  ///
  bool showLabel1 = true;
  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /* final String prefix =
        'AG-${DateFormat('yy', 'fr_FR').format(DateTime.now())}-'; */
    final Widget codeTextField = TextField(
      //autofocus: true,
      controller: codeController,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      onTap: () {
        setState(() {
          showLabel1 = false;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        /* prefix: AppText.medium(prefix), */
        label: showLabel1 ? AppText.medium('Entrer le code') : Container(),
        border: InputBorder.none,
      ),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        elevation: 0,
        /* leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ), */
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: AppText.medium(
            'Double tape pour quitter',
            color: Palette.whiteColor,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: size.height / 1.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              //const AllSheetHeader(),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    AppText.medium('Vérifier le code'),
                    AppText.small(
                      'Utiliser le code de pré-inscription pour valider l\'inscription',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 35, left: 35, top: 30),
                      child: InfosColumn(
                        height: 50,
                        opacity: 0.2,
                        label: 'Code',
                        widget: Expanded(
                          child: codeTextField,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 35, left: 35, top: 10),
                      child: CustomButton(
                        color: Color.fromARGB(255, 229, 185, 9),
                        width: double.infinity,
                        height: 35,
                        radius: 5,
                        text: 'Vérifier',
                        onPress: () {
                          String code = codeController.text.trim();
                          if (code.isEmpty) {
                            Functions.showToast(
                                message: 'Veuillez fournir un code');
                          } else if (int.tryParse(code) == null) {
                            Vibration.vibrate(duration: 200);
                            Functions.showToast(message: 'Code invalide !');
                          } else {
                            Functions.showBottomSheet(
                              ctxt: context,
                              widget: SheetContainer(code: code),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
