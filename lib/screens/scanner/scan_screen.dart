import 'package:flutter/cupertino.dart';
import 'package:scanner/config/palette.dart';
import 'package:scanner/screens/scanner/widgets/infos_column.dart';
import 'package:scanner/widgets/all_sheet_header.dart';
import 'package:scanner/widgets/custom_button.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/app_text.dart';
import '../../config/functions.dart';
import '../../config/overlay.dart';
import '../side_bar/custom_side_bar.dart';
import 'widgets/error_sheet_container.dart';
import 'widgets/sheet_container.dart';

class ScanSreen extends StatefulWidget {
  static String routeName = '/scannerScreen';
  const ScanSreen({super.key});

  @override
  State<ScanSreen> createState() => _ScanSreenState();
}

class _ScanSreenState extends State<ScanSreen> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFontCamera = false;
  bool isVerifyCodeState = true;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  MobileScannerController mobileScannerController = MobileScannerController();
  void closeScreen() {
    isScanCompleted = false;
  }

  ////////////////
  ///
  AudioCache player = AudioCache();

  //////////////////
  ///
  List<String> toggle = ['Scanner', 'vérifier un code'];
  ///////////
  ///
  int selectdeIndx = 0;

  /////////////////:
  ///
  ///
  @override
  void initState() {
    if (isVerifyCodeState) {
      mobileScannerController;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    //fit: BoxFit.cover,

                    controller: mobileScannerController,
                    allowDuplicates: true,
                    onDetect: (barcodes, args) {
                      if (!isScanCompleted) {
                        String code = barcodes.rawValue ?? '...';
                        print(code);
                        isScanCompleted = true;
                        int? id = int.tryParse(code);
                        if (id != null) {
                          player.play('images/soung.mp3');
                          Functions.showBottomSheet(
                            ctxt: context,
                            widget: SheetContainer(qrValue: code),
                          );
                        } else {
                          /////////// fiare vibrer le device
                          ///
                          Vibration.vibrate(duration: 200);
                          Functions.showBottomSheet(
                            ctxt: context,
                            widget: const ErrorSheetContainer(),
                          );
                        }

                        /////
                        Future.delayed(const Duration(seconds: 5)).then((_) {
                          setState(() {
                            isScanCompleted = false;
                          });
                        });
                      }
                    },
                  ),
                  const QRScannerOverlay(overlayColour: Colors.transparent),

                  //////////////////////////////////////////:
                  /// toggles buttons
                  /// /////////////////////////////////////:
                  Positioned(
                    bottom: 0,
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17.0, horizontal: 8.0),
                        width: size.width,
                        height: 80,
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            height: size.height,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Row(
                              children: List.generate(
                                toggle.length,
                                (index) {
                                  return Expanded(
                                    child: InkWell(
                                      onTap: () => setState(() {
                                        selectdeIndx = index;
                                        if (selectdeIndx == 1) {
                                          Functions.showBottomSheet(
                                            ctxt: context,
                                            widget: VerifyCodeSheet(
                                              size: size,
                                              changeIndexState: () =>
                                                  setState(() {
                                                selectdeIndx = 0;
                                              }),
                                            ),
                                          );
                                        }
                                      }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: index == selectdeIndx
                                              ? Palette.whiteColor
                                              : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: AppText.medium(
                                            toggle[index],
                                            color: index == selectdeIndx
                                                ? Colors.black
                                                : Palette.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////////:
                  /// end toggles buttons
                  ////////////////////////////////////:

                  ///////////////////////////////////
                  /// flash toggle bottuons
                  Positioned(
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      width: size.width,
                      //height: 100,
                      color: Colors.black.withOpacity(0.2),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText.medium(
                              'Place the QR code in the area',
                              color: Palette.whiteColor,
                            ),
                            AppText.small(
                              'Scanning will be started automatically',
                              color: Palette.whiteColor,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: size.width / 3.5,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isFlashOn = !isFlashOn;
                                        });
                                        print(mobileScannerController
                                            .torchState.value
                                            .toString());
                                        if (mobileScannerController
                                                .torchState.value
                                                .toString() ==
                                            "TorchState.off") {
                                          mobileScannerController.toggleTorch();
                                        }
                                        ;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isFlashOn
                                              ? Palette.whiteColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            CupertinoIcons.light_max,
                                            color: isFlashOn
                                                ? Colors.black
                                                : Palette.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isFlashOn = !isFlashOn;
                                        });
                                        if (mobileScannerController
                                                .torchState.value
                                                .toString() ==
                                            "TorchState.on") {
                                          mobileScannerController.toggleTorch();
                                        }
                                        ;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: !isFlashOn
                                              ? Palette.whiteColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            CupertinoIcons.light_min,
                                            color: !isFlashOn
                                                ? Colors.black
                                                : Palette.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////

  ///
  ///////////////////////
}

class VerifyCodeSheet extends StatefulWidget {
  VerifyCodeSheet({
    super.key,
    required this.size,
    required this.changeIndexState,
  });

  final Size size;
  final VoidCallback changeIndexState;

  @override
  State<VerifyCodeSheet> createState() => _VerifyCodeSheetState();
}

class _VerifyCodeSheetState extends State<VerifyCodeSheet> {
  ///
  bool showLabel1 = true;
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget codeTextField = TextField(
      keyboardType: TextInputType.number,
      controller: codeController,
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
        //prefix: AppText.medium(prefix),
        label: showLabel1
            ? AppText.medium('Entrer le code de vérification')
            : Container(),
        border: InputBorder.none,
      ),
    );

    return Container(
      height: MediaQuery.of(context).viewInsets.bottom + 150,
      width: widget.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              widget.changeIndexState();
              Navigator.pop(context);
            },
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          ///////////////////
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: InfosColumn(
              height: 50,
              opacity: 0.3,
              label: 'code',
              widget: Expanded(
                child: codeTextField,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: CustomButton(
              color: Color.fromARGB(255, 205, 166, 12),
              width: double.infinity,
              height: 40,
              radius: 5,
              text: 'Vérifier',
              onPress: () {},
            ),
          )
        ],
      ),
    );
  }
}
