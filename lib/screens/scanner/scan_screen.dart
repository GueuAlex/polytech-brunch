import 'package:flutter/cupertino.dart';
import 'package:scanner/config/palette.dart';
import 'package:scanner/model/my_user.dart';
import 'package:scanner/screens/scanner/widgets/infos_column.dart';
import 'package:scanner/widgets/all_sheet_header.dart';
import 'package:scanner/widgets/custom_button.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/app_text.dart';
import '../../config/functions.dart';
import '../../config/overlay.dart';
import 'widgets/error_sheet_container.dart';
import 'widgets/sheet_container.dart';
import 'widgets/sheet_header.dart';

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
  List<String> toggle = ['Scanner', 'Inscrire'];
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
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: AppText.medium(
            'Double tape pour quitter',
            color: Palette.whiteColor,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    /////////////
                    ///
                    MobileScanner(
                      //fit: BoxFit.cover,
                      controller: mobileScannerController,
                      allowDuplicates: true,
                      ////////////////
                      // onDetect: fonction lancée lorsqu'un rq code est
                      // detecté par la cam
                      ////////////////////
                      onDetect: (barcodes, args) async {
                        if (!isScanCompleted) {
                          ////////////////
                          /// code =  données que le qrcode continet
                          String code = barcodes.rawValue ?? '...';
                          //print(code);
                          //////////////
                          /// booleen permettant de connaitre l'etat
                          /// du process de scanning
                          isScanCompleted = true;
                          //////////////////////////
                          /// on attend un int
                          /// donc on int.tryParse code pour etre sur de
                          /// son type
                          int? data = int.tryParse(code);

                          ///
                          /////////////////////////////
                          ///data represente le code de préinscription
                          ///d'un participant dans notre DB
                          /// si data n'est pas null, on recherche
                          /// le participant en fonction du data ........
                          if (data != null) {
                            MyUserModel? user = findUser(code: data.toString());

                            //////////////////////////////////////:::::
                            /// aucun participant trouvé avec ce code
                            /// de participation ?
                            if (user == null) {
                              /////////
                              ///
                              Vibration.vibrate(duration: 200);
                              Functions.showBottomSheet(
                                ctxt: context,
                                widget: Container(
                                  height: size.height / 2.5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: SafeArea(
                                    child: Column(
                                      children: [
                                        const AllSheetHeader(),
                                        Expanded(
                                          child: Functions.widget404(
                                            size: size,
                                            ctxt: context,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              ///////////////
                            }
                            if (user!.isChecked == 1) {
                              Vibration.vibrate(duration: 200);
                              Functions.showBottomSheet(
                                ctxt: context,
                                widget: Container(
                                  height: size.height / 2.5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: SafeArea(
                                    child: Column(
                                      children: [
                                        const AllSheetHeader(),
                                        Expanded(
                                            child: Functions.inactifQrCode(
                                          ctxt: context,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              //////////////////////
                              /// PREMIER SCAN
                              /////////////////////////
                              player.play('images/soung.mp3');

                              Functions.showBottomSheet(
                                ctxt: context,
                                widget: Container(
                                  height: size.height / 1.8,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: SafeArea(
                                    child: Column(
                                      children: [
                                        const AllSheetHeader(),
                                        Expanded(
                                            child: SingleChildScrollView(
                                                child: Column(
                                          children: [
                                            SheetHeader(
                                              user: user,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: participant(
                                                user: user,
                                              ),
                                            ),
                                          ],
                                        )))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            /* player.play('images/soung.mp3');
                            Functions.showBottomSheet(
                              ctxt: context,
                              widget: SheetContainer(code: code),
                            ); */
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
                          Future.delayed(const Duration(seconds: 3)).then((_) {
                            setState(() {
                              isScanCompleted = false;
                            });
                          });
                        }
                      },
                    ),
                    ///////////////
                    ///
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
                                                    setState(
                                                  () {
                                                    selectdeIndx = 0;
                                                  },
                                                ),
                                              ),
                                            ).whenComplete(() {
                                              setState(() {
                                                selectdeIndx = 0;
                                              });
                                            });
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
                              ////////////////////////
                              ///torch container
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
                                            isFlashOn = true;
                                          });

                                          if (mobileScannerController
                                                  .torchState.value
                                                  .toString() ==
                                              "TorchState.off") {
                                            mobileScannerController
                                                .toggleTorch();
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
                                            isFlashOn = false;
                                          });
                                          if (mobileScannerController
                                                  .torchState.value
                                                  .toString() ==
                                              "TorchState.on") {
                                            mobileScannerController
                                                .toggleTorch();
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
      ),
    );
  }

  ///////////////////////

  ///
  ///////////////////////
  MyUserModel? findUser({required String code}) {
    MyUserModel _user;
    for (MyUserModel u in MyUserModel.userList) {
      if (u.uniqueId == code) {
        _user = u;
        return _user;
      }
    }
    return null;
  }

  Widget participant({required MyUserModel user}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 150,
              height: 145,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Palette.appBlackColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/qr-model.png',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                children: [
                  InfosColumn(
                    label: 'Status',
                    widget: AppText.medium(user.status),
                  ),
                  const SizedBox(height: 10),
                  InfosColumn(
                    label: 'Code pré-inscription',
                    widget: AppText.medium(
                      user.uniqueId,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InfosColumn(
                    label: 'Email',
                    widget: AppText.medium(
                      '${user.email}',
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        CustomButton(
          color: Palette.appBlackColor,
          width: double.infinity,
          height: 35,
          radius: 5,
          text: 'Confirmer le scan',
          onPress: () {
            Map<String, dynamic> data = {
              "is_checked": 1,
            };
            Functions.showLoadingSheet(ctxt: context);
            Functions.updateIscheckedValue(data: data, userId: user.id)
                .whenComplete(
              () {
                user.isChecked = 1;
                Functions.getUserListFromApi();
                Functions.showToast(message: 'scan confirmé');
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          },
        ),
      ],
    );
  }
}

class ScanAlert extends StatefulWidget {
  final MyUserModel user;
  const ScanAlert({
    super.key,
    required this.user,
  });

  @override
  State<ScanAlert> createState() => _ScanAlertState();
}

class _ScanAlertState extends State<ScanAlert> {
  // bool isLoading = true;
  Map<String, dynamic> data = {
    "is_checked": 1,
  };
  @override
  void initState() {
    Functions.updateIscheckedValue(data: data, userId: widget.user.id);
    widget.user.isChecked = 1;
    Functions.getUserListFromApi();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pop(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(10),
        height: size.height,
        width: double.infinity,
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Palette.whiteColor,
            ),
            child: Image.asset('assets/images/check.gif'),
          ),
        ),
      ),
    );
  }
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
              onPress: () {
                String code = codeController.text.trim();
                if (code.isEmpty) {
                  Functions.showToast(message: 'Veuillez fournir un code');
                }
                if (int.tryParse(code) == null) {
                  Vibration.vibrate(duration: 200);
                  Functions.showToast(message: 'Code invalide !');
                } else {
                  Functions.showBottomSheet(
                    ctxt: context,
                    widget: SheetContainer(code: code),
                  );
                }
                ;
              },
            ),
          )
        ],
      ),
    );
  }
}
