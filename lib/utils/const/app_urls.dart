// ignore_for_file: use_build_context_synchronously

import 'package:caretaker/modules/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class AppUrls {
  static const String phone = "+918867319944";
  static const String fontFamilyKanit = 'Kanit';
  static const baseUrl = "https://api.rentiseazy.com/aa/";
  static const imagesRootUrl =
      "http://networkgroups.in/prisma/rentitezy/images/";
  // static const rootUrl = "http://networkgroups.in/prisma/rentitezy/";
  // static const imagesRootUrl =
  //     "http://networkgroups.in/prisma/rentitezy/images/";
  // static const rootUrl = "http://192.168.1.204:8136/prisma/rentitezy/";
  // static const imagesRootUrl =
  //     "http://192.168.1.204:8136/prisma/rentitezy/images/";
  static const careTaker = "${baseUrl}leads";
  static const careTakerLogin = "${baseUrl}login";
  static const properties = "${baseUrl}listingDetail";
  static const ticket = "${baseUrl}ticket";
  static const tickets = "${baseUrl}tickets";
  static const ticketsConfig = "${baseUrl}ticketConfig";
  //static const otTicket = "${rootUrl}ot_ticket";
  static const urlImgUpload = "${baseUrl}fileUpload";

  static Future<void> alertDialog(
      BuildContext context, String title, String subttitle) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title,
              style: TextStyle(
                fontFamily: Constants.fontsFamily,
              )),
          content: Text(subttitle,
              style: TextStyle(
                fontFamily: Constants.fontsFamily,
              )),
          actions: [
            CupertinoDialogAction(
                child: Text("YES",
                    style: TextStyle(
                      fontFamily: Constants.fontsFamily,
                    )),
                onPressed: () async {
                  executeLogOut(context);
                }),
            CupertinoDialogAction(
              child: Text("NO",
                  style: TextStyle(
                    fontFamily: Constants.fontsFamily,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

executeLogOut(BuildContext context) async {
  final SharedPreferences prefs = await _prefs;
  GetStorage().write(Constants.isLogin, false);
  GetStorage().write(Constants.usernamekey, "guest");
  GetStorage().write(Constants.userId, "guest");
  GetStorage().write(Constants.phonekey, "guest");
  GetStorage().write(Constants.emailkey, "guest");

  Navigator.pop(context);
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
}

String convertToAgo(String dateTime) {
  DateTime input = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(dateTime, true);
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}

class Constants {
  static String fontsFamily = 'Kanit';
  static const usernamekey = "usernamekey";
  static const propertyId = "propertyId";
  static const profileUrl = "profileUrl";
  static const userId = "userId";
  static const token = "token";
  static const isLogin = "isLogin";
  static const emailkey = "emailkey";
  static const phonekey = "phonekey";
  static const currency = 'Rs.';


}
