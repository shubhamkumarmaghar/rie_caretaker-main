// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/custom_theme.dart';

import '../../utils/const/app_urls.dart';
import '../../utils/const/widgets.dart';
import 'controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height(0.05),
                SizedBox(
                    height: 170,
                    width: 250,
                    child: Image.asset(
                      'assets/images/login_image.png',
                      fit: BoxFit.fill,
                    )),
                title("Welcome", 27),
                titleClr("RENTISEASY ADMIN", 20, Colors.grey, FontWeight.bold),
                height(0.05),
                inputField('Phone Number', loginController.unameController, 5),
                inputField('Password', loginController.uPasswordController, 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomTheme.appTheme,
                    ),
                    onPressed: () {
                      if (loginController.unameController.text.isEmpty) {
                        showCustomToast(context, 'Enter valid username');
                      } else if (loginController.uPasswordController.text.isEmpty) {
                        showCustomToast(context, 'Enter valid password');
                      } else {
                        loginController.careTakerRequest();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 27, right: 27),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: Constants.fontsFamily,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  Widget inputField(
      String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CustomTheme.white,
          border: Border.all(color: const Color.fromARGB(255, 227, 225, 225)),
        ),
        child: TextField(
          controller: tController,
          decoration: InputDecoration(
              hoverColor: CustomTheme.appThemeContrast2,
              hintText: hind,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
