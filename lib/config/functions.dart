import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scanner/config/palette.dart';
import 'package:scanner/model/my_user.dart';

import '../remote_service/remote_service.dart';
import '../widgets/custom_button.dart';
import 'app_text.dart';

class Functions {
  static showLoadingSheet({required BuildContext ctxt}) {
    return showDialog(
      context: ctxt,
      //backgroundColor: Colors.transparent,
      builder: (ctxt) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(ctxt).size.height,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: LoadingAnimationWidget.newtonCradle(
                  color: Palette.appBlackColor,
                  size: 55,
                ),
              ),
              const SizedBox(
                height: 230,
              )
            ],
          ),
        );
      },
    );
  }

  static showSnackBar({required BuildContext ctxt, required String messeage}) {
    return ScaffoldMessenger.of(ctxt).showSnackBar(
      SnackBar(
        content: AppText.medium(
          messeage,
          color: Colors.white70,
        ),
        duration: const Duration(seconds: 3),
        elevation: 5,
      ),
    );
  }

  static Future<void> showBottomSheet({
    required BuildContext ctxt,
    required Widget widget,
  }) async {
    return await showModalBottomSheet(
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      context: ctxt,
      builder: (context) {
        return widget;
      },
    );
  }

  // retourne la liste des qr code depuis l'api
  static getUserListFromApi() async {
    MyUserModel.userList = await RemoteService().getUserList();
  }

  static showToast(
      {required String message, Color bgColor = Palette.blackColor}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static //Alert de sortie définitive
      Future<Null> alert1({
    required BuildContext ctxt,
    required Function() confirm,
    required Function() cancel,
  }) async {
    return showDialog(
        barrierDismissible: false,
        context: ctxt,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: AppText.medium('Confirmation'),
            content: AppText.small(
              'Attention, cette action entraînera la désactivation du QR code et du code associé.',
              textAlign: TextAlign.left,
            ),
            contentPadding: const EdgeInsets.only(
              top: 5.0,
              right: 15.0,
              left: 15.0,
            ),
            titlePadding: const EdgeInsets.only(
              top: 10,
              left: 15,
            ),
            actions: [
              TextButton(
                onPressed: confirm,
                child: AppText.small(
                  'Confirmer',
                  fontWeight: FontWeight.w500,
                  color: Palette.primaryColor,
                ),
              ),
              TextButton(
                onPressed: cancel,
                child: AppText.small(
                  'Annuler',
                  fontWeight: FontWeight.w500,
                  color: Palette.primaryColor,
                ),
              )
            ],
          );
        });
  }

  static //affiche un alerte dialogue de confirmation en cas de modification
      Future<Null> alert({
    required MyUserModel user,
    required BuildContext ctxt,
    required Function() confirm,
    required Function() cancel,
  }) async {
    return showDialog(
      barrierDismissible: false,
      context: ctxt,
      builder: (BuildContext ctxt) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: AppText.medium('Confirmation'),
          content: AppText.small(
            'Vous confirmez l\'inscription ?\n${user.firstname} recevra un email contenant son ticket',
            textAlign: TextAlign.left,
          ),
          contentPadding: const EdgeInsets.only(
            top: 5.0,
            right: 15.0,
            left: 15.0,
          ),
          titlePadding: const EdgeInsets.only(
            top: 10,
            left: 15,
          ),
          actions: [
            TextButton(
              onPressed: confirm,
              child: AppText.small(
                'Confirmer',
                fontWeight: FontWeight.w500,
                color: Palette.primaryColor,
              ),
            ),
            TextButton(
              onPressed: cancel,
              child: AppText.small(
                'Annuler',
                fontWeight: FontWeight.w500,
                color: Palette.primaryColor,
              ),
            )
          ],
        );
      },
    );
  }

  static Widget inactifQrCode({required BuildContext ctxt}) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/disconnect.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppText.medium('Oops !'),
          AppText.small('Ce Qr code a déjà été scanné !'),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            color: Palette.appBlackColor,
            width: double.infinity,
            height: 35,
            radius: 5,
            text: 'Retour',
            onPress: () => Navigator.pop(ctxt),
          )
        ],
      ),
    );
  }

  /// renvoi un widget avec a l'intérieur un érreur 404
  static Widget widget404({required Size size, required BuildContext ctxt}) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      //height: size.height / 1.5,
      width: size.width,
      child: Center(
        child: Column(
          children: [
            Container(
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset('assets/icons/404.svg'),
            ),
            //AppText.medium('Not found !'),
            AppText.small('Aucune correspondance !'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              color: Palette.appBlackColor,
              width: double.infinity,
              height: 35,
              radius: 5,
              text: 'Retour',
              onPress: () => Navigator.pop(ctxt),
            )
          ],
        ),
      ),
    );
  }

  static generateQrCode({required String uniqueId}) async {
    int response = await RemoteService().postUserCode(uniqueId: uniqueId);
    print(response);

    if (response == 200) {
      showToast(message: 'Inscription réussie !');
    } else {
      showToast(message: 'Veuillez réessayer !');
    }
  }

  // met a jour un user
  static Future<dynamic> updateIscheckedValue({
    required Map<String, dynamic> data,
    required int userId,
  }) async {
    var response = await RemoteService().putSomethings(
      api: 'users/${userId}',
      data: data,
    );
    return response;
  }

  static Uint8List getImage({required MyUserModel user}) {
    final String base64Image = user.qrcode;
    Uint8List bytes = base64.decode(base64Image);
    return bytes;
  }
}
