import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../const/widgets.dart';

void showProgressLoader(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        backgroundColor: Colors.white,
        elevation: 2.0,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: BoxConstraints(
            maxHeight: 200.0,
            maxWidth: screenWidth * 0.3,
          ),
          child: const SizedBox(
            height: 24.0,
            width: 24.0,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    },
  );
}

void cancelLoader() {
  Get.back();
}
