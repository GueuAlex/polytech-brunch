import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner/model/my_user.dart';
import 'package:scanner/remote_service/remote_service.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/scan.dart';
import '../../../widgets/all_sheet_header.dart';
import '../../../widgets/custom_button.dart';
import 'infos_column.dart';
import 'sheet_header.dart';

class SheetContainer extends StatefulWidget {
  ///:::::::::::///////////////////:
  /// a utiliser pour l'api
  final String qrValue;
  ////////:::::::::::::////////////////
  const SheetContainer({
    super.key,
    required this.qrValue,
  });

  @override
  State<SheetContainer> createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  bool showLabel1 = true;
  bool showLabel2 = true;
  bool isLoading = true;

  ///////////////////
  final TextEditingController iDController = TextEditingController();
  final TextEditingController cariDController = TextEditingController();
  //////////////
  MyUserModel? user;

  @override
  void initState() {
    getUser(id: int.parse(widget.qrValue));
    Future.delayed(const Duration(seconds: 4)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  getUser({required int id}) async {
    MyUserModel? data = await RemoteService().getSingleUser(id: id);

    if (data != null) {
      user = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget idTextField = TextField(
      controller: iDController,
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
        label:
            showLabel1 ? AppText.medium('Entrez un n° de pièce') : Container(),
        border: InputBorder.none,
      ),
    );
    ////////////////////////
    ///
    ///
    final Widget cardIddTextField = TextField(
      controller: cariDController,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      onTap: () {
        setState(() {
          showLabel2 = false;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: showLabel2
            ? AppText.medium(
                'Entrez un n° d\'immatriculation de véhicule',
              )
            : Container(),
        border: InputBorder.none,
      ),
    );
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.only(top: size.height - (size.height / 1.3)),
        height: size.height / 1.3,
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
            Expanded(
              child: !isLoading
                  ? SingleChildScrollView(
                      child: user != null
                          ? Column(
                              children: [
                                SheetHeader(user: user!),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: user!.isAlreadyScanned == 0
                                      ? firstScanColumn(
                                          idTextField: idTextField,
                                          cardIddTextField: cardIddTextField,
                                        )
                                      : isAlreadyScanColumn(),
                                ),
                              ],
                            )
                          : Container(
                              height: size.height / 1.5,
                              width: size.width,
                              child: Center(
                                child: AppText.medium('user not found !'),
                              ),
                            ),
                    )
                  : Center(
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        child: Center(
                          child: Image.asset('assets/images/loading.gif'),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget isAlreadyScanColumn() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: InfosColumn(
                label: 'Date d\'entrée',
                widget: AppText.medium(
                  DateFormat(
                    'dd MMM yyyy',
                    'fr_FR',
                  ).format(
                    user!.dateVisite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InfosColumn(
                label: 'Heure d\'entrée',
                widget: AppText.medium(
                  user!.heureEntreeViste.substring(0, 5),
                ),
              ),
            ),
            Expanded(
              child: InfosColumn(
                label: 'Heure de sortie',
                widget: user!.heureSortieVisite == null
                    ? AppText.medium(
                        DateFormat('HH:mm', 'fr_FR').format(
                          DateTime.now(),
                        ),
                      )
                    : AppText.medium(user!.heureSortieVisite!.substring(0, 5)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        user!.heureSortieVisite == null
            ? CustomButton(
                color: Color.fromARGB(255, 57, 143, 77),
                width: double.infinity,
                height: 35,
                radius: 5,
                text:
                    // 'Marquer ${DateFormat('HH:mm', 'fr_FR').format(DateTime.now())} comme heure de fin',
                    'Marquer la fin de visite',
                onPress: () {
                  String heureFin = DateFormat('HH:mm', 'fr_FR').format(
                    DateTime.now(),
                  );
                  MyUserModel _user = MyUserModel(
                    id: user!.id,
                    nom: user!.nom,
                    prenoms: user!.prenoms,
                    dateVisite: user!.dateVisite,
                    heureEntreeViste: user!.heureEntreeViste,
                    email: user!.email,
                    number: user!.number,
                    numeroCni: iDController.text,
                    plaqueVehicule: cariDController.text,
                    heureSortieVisite: heureFin,
                  );

                  Map<String, dynamic> data = {
                    "heure_sortie_visite": heureFin,
                  };
                  upDateUser(
                    userId: user!.id,
                    data: data,
                  );
                  ScanModel scanModel = ScanModel(
                    id: Random().nextInt(10).toString(),
                    date: DateTime.now(),
                    data: _user,
                  );
                  ScanModel.scans
                      .removeWhere((element) => element.data.id == _user.id);
                  ScanModel.scans.add(scanModel);
                  //MyUserModel.userList.add(_user);
                  Navigator.pop(context);
                  Functions.showSnackBar(
                    ctxt: context,
                    messeage: 'Fin de visite !',
                  );
                },
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          color: Palette.secondaryColor,
          width: double.infinity,
          height: 35,
          radius: 5,
          text: user!.heureSortieVisite == null ? 'Annuler' : 'Retour',
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget firstScanColumn({
    required Widget idTextField,
    required Widget cardIddTextField,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfosColumn(
                label: 'Date d\'entrée',
                widget: AppText.medium(
                  DateFormat(
                    'dd MMM yyyy',
                    'fr_FR',
                  ).format(
                    user!.dateVisite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InfosColumn(
                label: 'Heure d\'entrée',
                widget: AppText.medium(
                  user!.heureEntreeViste.substring(0, 5),
                ),
              ),
            ),
          ],
        ),
        InfosColumn(
          opacity: 0.3,
          label: 'n° de pièce',
          widget: Expanded(
            child: idTextField,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        InfosColumn(
          opacity: 0.3,
          label: 'n° d\'immatriculation véhicule',
          widget: Expanded(
            child: cardIddTextField,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          color: Palette.primaryColor,
          width: double.infinity,
          height: 35,
          radius: 5,
          text: 'Sauvegarder le scan',
          onPress: () {
            MyUserModel _user = MyUserModel(
              id: user!.id,
              nom: user!.nom,
              prenoms: user!.prenoms,
              dateVisite: user!.dateVisite,
              heureEntreeViste: user!.heureEntreeViste,
              email: user!.email,
              number: user!.number,
              numeroCni: iDController.text,
              plaqueVehicule: cariDController.text,
            );
            Map<String, dynamic> data = {
              "numero_cni": iDController.text,
              "plaque_vehicule": cariDController.text,
              "is_already_scanned": 1,
            };
            upDateUser(
              userId: user!.id,
              data: data,
            );
            ScanModel scanModel = ScanModel(
              id: '1',
              date: DateTime.now(),
              data: _user,
            );
            ScanModel.scans.add(scanModel);
            MyUserModel.userList.add(_user);
            Navigator.pop(context);
            Functions.showSnackBar(
              ctxt: context,
              messeage: 'Scan sauvegardé !',
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          color: Palette.secondaryColor,
          width: double.infinity,
          height: 35,
          radius: 5,
          text: 'Annuler',
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Future<dynamic> upDateUser({
    required Map<String, dynamic> data,
    required int userId,
  }) async {
    var response = await RemoteService().putUser(
      api: 'visiteurs/${userId}',
      data: data,
    );
  }
}
