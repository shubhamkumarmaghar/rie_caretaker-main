// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:caretaker/modules/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/intl.dart';

class AppUrls {
  static const String phone = "+918867319944";
  static const String fontFamilyKanit = 'Kanit';
  static const productionUrl  = "https://api.rentiseazy.com/aa/";
  static const developmentUrl = "https://test-api.rentiseazy.com/aa/";
  static const baseUrl = developmentUrl;
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
  static const uploadCallLogs = "${baseUrl}callLogs";
  static const getLastCallTimestamp = "${baseUrl}lastCall";
  static const getMoveInOut = "${baseUrl}moveInOuts";
  static const moveIn = "${baseUrl}moveIn";
  static const moveOut = "${baseUrl}moveOut";
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
  GetStorage().write(Constants.isLogin, false);

  Navigator.pop(context);
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
}

String dateConvert(String date){
  String dateTime;
  try{
    if(date.isNotEmpty) {
      DateTime datee = DateTime.parse(date);
     // dateTime = DateFormat('dd-MM-yyyy, hh:mm a').format(datee);
      dateTime = DateFormat('dd-MM-yyyy').format(datee);
    }
    else{
      dateTime='NA';
    }
  }
  catch (e)
  {
    log('error exception ::$e');
    dateTime='NA';
  }
  return dateTime;
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
  static const callSync = 'callSync';
  static const isLogin = "isLogin";
  static const emailkey = "emailkey";
  static const phonekey = "phonekey";
  static const rolekey = "role";
  static const lastCallStamp = "lastCall";
  static const currency = 'Rs.';
  static const background = 'background';


}
