// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:caretaker/models/care_taker_model.dart';
import 'package:caretaker/modules/home/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/caretaker_login_new.dart';
import '../theme/custom_theme.dart';
import '../utils/const/api.dart';
import '../utils/const/app_urls.dart';
import '../utils/const/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController unameController = TextEditingController();
  TextEditingController uPasswordController = TextEditingController();

  Widget inputFelid(
      String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CustomTheme.appTheme,
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

  Widget inputFeildPh(
      String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CustomTheme.appThemeContrast2,
          border: Border.all(color: const Color.fromARGB(255, 227, 225, 225)),
        ),
        child: TextField(
          controller: tController,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          maxLength: 10,
          decoration: InputDecoration(
              counter: const SizedBox(),
              hoverColor: CustomTheme.appThemeContrast2,
              hintText: hind,
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget inputFeildEmail(
      String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CustomTheme.appTheme,
          border: Border.all(color: const Color.fromARGB(255, 227, 225, 225)),
        ),
        child: TextField(
          controller: tController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hoverColor: CustomTheme.appThemeContrast2,
              hintText: hind,
              border: InputBorder.none),
        ),
      ),
    );
  }

  void careTakerRequest() async {
    var sharedPreferences = await _prefs;
    //CareTakerModel? ctModel;
    CareTakerLoginModelNew ctModel;
    try {
      dynamic result =
          await careTLogin(unameController.text, uPasswordController.text);
      var userId = '${result['userId']}';
      // if (result['success']) {
      if (userId.isNotEmpty) {
        ctModel = CareTakerLoginModelNew.fromJson(result);
       // ctModel = CareTakerModel.fromJson(result);
        GetStorage().write(Constants.isLogin, true);
        GetStorage().write(Constants.token, ctModel.token.toString());
        //sharedPreferences.setBool(Constants.isLogin, true);
        GetStorage().write(Constants.token, ctModel.token.toString());
        GetStorage().write(Constants.userId, ctModel.userId.toString());
        GetStorage().write(
            Constants.propertyId, jsonEncode(ctModel.propertyId));
        GetStorage().write(Constants.phonekey, '${ctModel.phone}');
        GetStorage().write(Constants.profileUrl, '${ctModel.image}');
        GetStorage().write(Constants.usernamekey, '${ctModel.name}');
        GetStorage().write(Constants.emailkey, '${ctModel.email}');
        log(GetStorage().read(Constants.token));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        showCustomToast(context, 'Invalid Credentials');
      }
      // } else {
      //   showCustomToast(context, result['message']);
      // }

      //if (ctModel.id != null) {

      // }
    } on Exception catch (error) {
      showCustomToast(context, error.toString());
      log('login ${error}');
      //Navigator.pop(context);
    }
  }

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
                inputFelid('User name', unameController, 5),
                inputFelid('Password', uPasswordController, 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomTheme.appTheme,
                    ),
                    onPressed: () {
                      if (unameController.text.isEmpty) {
                        showCustomToast(context, 'Enter valid username');
                      } else if (uPasswordController.text.isEmpty) {
                        showCustomToast(context, 'Enter valid password');
                      } else {
                        careTakerRequest();
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
}
