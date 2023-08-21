import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:scanner/screens/scanner/widgets/infos_column.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import '../../../widgets/custom_button.dart';
import '../../home/home.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showLabel1 = true;
  final TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    /////////////::
    ///
    final Widget loginTextField = TextField(
      controller: loginController,
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
        label: showLabel1
            ? AppText.medium('Entrez votre n° matricule')
            : Container(),
        border: InputBorder.none,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.2),
        title: AppText.medium('Authentification'),
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content:
              AppText.medium('Double clic pour quitter', color: Colors.grey),
        ),
        child: Container(
          height: size.height,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.2),
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.vpn_key),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AppText.large('Bonjour'),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: AppText.small(
                            'Veuillez renseigner votre numéro matricule',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: size.height * 0.21),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  right: 25.0,
                                  left: 25.0,
                                  bottom: 15,
                                ),
                                child: InfosColumn(
                                  opacity: 0.1,
                                  label: 'N° matricule',
                                  widget: Expanded(
                                    child: loginTextField,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 25.0,
                                left: 25.0,
                              ),
                              child: CustomButton(
                                color: Palette.primaryColor,
                                width: double.infinity,
                                height: 40,
                                radius: 5,
                                text: 'Connexion',
                                onPress: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Home.routeName,
                                    (route) => false,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
