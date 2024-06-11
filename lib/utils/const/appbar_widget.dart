import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';

import 'widgets.dart';

String assetImg = 'assets/images/app_logo.png';
String userVec = 'assets/images/user_vec.png';
PreferredSizeWidget appBarWidget(
    String titleTxt, String image, BuildContext context, bool isVisible) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    title: Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.030, //top: screenHeight * 0.015
       ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleClr(titleTxt, 19, Colors.white, FontWeight.bold),
        ],
      ),
    ),
    leading: isVisible
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          )
        : null,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: CustomTheme.appTheme),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
    ),
  );
}
