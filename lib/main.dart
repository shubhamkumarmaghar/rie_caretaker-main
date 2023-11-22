// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:caretaker/modules/login_screen.dart';
import 'package:caretaker/utils/const/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/main_screen/view/main_screen.dart';

void main() {
  runApp(const MyApp());
  GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RENTISEASY ADMIN',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    goToSplash();
    super.initState();
  }

  void goToSplash() async {
    Timer(const Duration(seconds: 3), () async {
    //  var sharedPreferences = await _prefs;
        if (
            GetStorage().read(Constants.isLogin) != false) {
          debugPrint('0000');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        } else {
          debugPrint('1111');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/splash_logo.png',
        height: 100,
        width: 100,
      ),
    ));
  }
}
