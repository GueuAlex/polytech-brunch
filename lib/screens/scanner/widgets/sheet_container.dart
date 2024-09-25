import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:scanner/model/my_user.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../widgets/all_sheet_header.dart';
import '../../../widgets/custom_button.dart';
import 'infos_column.dart';
import 'sheet_header.dart';

class SheetContainer extends StatefulWidget {
  ///:::::::::::///////////////////:
  /// a utiliser pour l'api
  /// on va utilise qrValue, pour une requet get dans notre api
  /// pour obtenir toutes les infos du rqcode qu'on vient de scanné
  final String code;
  ////////:::::::::::::////////////////
  const SheetContainer({
    super.key,
    required this.code,
  });

  @override
  State<SheetContainer> createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  bool showLabel1 = true;
  bool showLabel2 = true;

  ////////////////
  ///nous permet d'afficher un gift de chargement
  ///mais je ne suis pas sûr de cette de methode
  ///a changer plutard
  bool isLoading = true;

  ///////////////////
  final TextEditingController iDController = TextEditingController();
  final TextEditingController cariDController = TextEditingController();
  //////////////
  ///
  MyUserModel? user;

  @override
  void initState() {
    print(MyUserModel.userList.length);
    //getUser(id: int.parse(widget.qrValue));
    //getQrCode(qrCodeId: int.parse(widget.qrValue));
    /////////
    findUser(uniqueCode: widget.code);
    Future.delayed(const Duration(seconds: 4)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  /////////////////////////////////////////////////////:
  /// trouvé le user dans la liste global des user
  ///
  findUser({required String uniqueCode}) async {
    user = await MyUserModel.userList
        .firstWhere((element) => element.uniqueId == uniqueCode);
  }

  @override
  Widget build(BuildContext context) {
    // utilise dans code
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.only(top: size.height - (size.height / 1.8)),
        //height: size.height / 2,
        width: double.infinity,
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
                child: !isLoading
                    ? SingleChildScrollView(
                        child: user != null
                            ? Column(
                                children: [
                                  SheetHeader(
                                    user: user!,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: getWidget(
                                      user: user!,
                                    ),
                                  ),
                                ],
                              )
                            : Functions.widget404(size: size, ctxt: context),
                      )
                    : Center(
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          child: Center(
                            child: LoadingAnimationWidget.newtonCradle(
                              color: Palette.appBlackColor,
                              size: 70,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

// widget retourné si un qr code est scané pour la premiere fois
  Widget PreInscritWidget() {
    return user!.status == "pré-inscrit"
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InfosColumn(
                      label: 'Status',
                      widget: AppText.medium(user!.status),
                    ),
                  ),
                  Expanded(
                    child: InfosColumn(
                      label: 'Code pré-inscription',
                      widget: AppText.medium(
                        user!.uniqueId,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              InfosColumn(
                label: 'Email',
                widget: Expanded(
                  child: AppText.medium(
                    '${user!.email}',
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomButton(
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 35,
                radius: 5,
                text: 'Inscrire',
                //////////////////////////////////////////////////
                ///on a besoin update le n° CNI et le n° d'immatricule du user
                ///anisi l'attribut iSAlreadyScanned du qr code qu'on vient de scanné
                onPress: () {
                  int? respones;
                  Functions.alert(
                    user: user!,
                    ctxt: context,
                    confirm: () async {
                      Functions.showLoadingSheet(ctxt: context);
                      respones = await Functions.generateQrCode(
                        uniqueId: user!.uniqueId,
                      );

                      Future.delayed(const Duration(seconds: 3)).then(
                        (_) {
                          Functions.getUserListFromApi();
                          setState(() {
                            user!.status = "inscrit";
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          /* Functions.showSnackBar(
                            ctxt: context
                            messeage: 'Scan sauvegardé !',
                          ); */
                        },
                      );
                    },
                    cancel: () => Navigator.pop(context),
                    //user: user
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                color: Palette.appBlackColor,
                width: double.infinity,
                height: 35,
                radius: 5,
                text: 'Annuler',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        : Column(
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
                          widget: AppText.medium(user!.status),
                        ),
                        const SizedBox(height: 10),
                        InfosColumn(
                          label: 'Code pré-inscription',
                          widget: AppText.medium(
                            user!.uniqueId,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InfosColumn(
                          label: 'Email',
                          widget: AppText.medium(
                            '${user!.email}',
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
                text: 'Retour',
                onPress: () {
                  //Functions.showLoadingSheet(ctxt: context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
  }

  ///////////////////////////////////////////////
  ///fonction permettant de return un widget spécifique
  /// a l'etat du status du user
  /// selon :
  ///   1. si le status est "pré-inscrit"
  ///   2. si le status est "inscrit"

  Widget getWidget({
    //required QrCodeModel qrCodeModel,

    required MyUserModel user,
  }) {
    return PreInscritWidget();
  }

  /////////////////::
  ///
}
