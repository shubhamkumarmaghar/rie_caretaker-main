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
  bool obscureText = true;
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),

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
                height(0.05),
                Text(
                  'Welcome',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppUrls.fontFamilyKanit,
                      color: CustomTheme.appTheme,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'to',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppUrls.fontFamilyKanit,
                      color: CustomTheme.appTheme,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                titleClr("Sowerent Admin", 24, CustomTheme.appTheme, FontWeight.bold),
                height(0.05),
                inputField('Phone Number', loginController.unameController, 5),
                inputField('Password', loginController.uPasswordController, 10),
                height(0.1),
                Container(
                  height: 50,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.appTheme,
                      ),
                      onPressed: () {
                        if (loginController.unameController.text.isEmpty) {
                          showCustomToast(context, 'Enter valid username');
                        } else if (loginController.uPasswordController.text.isEmpty) {
                          showCustomToast(context, 'Enter valid password');
                        } else {
                          loginController.careTakerRequest(context);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: Constants.fontsFamily, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Widget inputField(String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CustomTheme.white,
          border: Border.all(color: CustomTheme.appTheme.withOpacity(0.2)),
        ),
        child: TextField(
          controller: tController,
          obscureText:hind == 'Password'
              ? obscureText:false,
          decoration: InputDecoration(
            hoverColor: CustomTheme.appThemeContrast2,
            hintText: hind,
            contentPadding:  EdgeInsets.only(left: 20, right: 20,bottom:hind == 'Password'? 5:0),
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.grey.shade400
            ),
            suffix: hind == 'Password'
                ? InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: obscureText ? CustomTheme.appTheme : Colors.grey,
                    ))
                : null,
          ),
        ),
      ),
    );
  }
}
