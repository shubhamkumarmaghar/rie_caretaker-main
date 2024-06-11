import 'dart:convert';
import 'dart:developer';
import 'package:caretaker/modules/login/caretaker_login_new.dart';
import 'package:caretaker/theme/custom_theme.dart';
import 'package:caretaker/utils/loader_dialogs/progress_loader.dart';
import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/const/app_urls.dart';
import '../../utils/services/rie_user_api_service.dart';
import '../main_screen/view/main_screen.dart';

class LoginController extends GetxController {
  CareTakerLoginModelNew? ctModel;
  RIEUserApiService rieUserApiService = RIEUserApiService();
  TextEditingController unameController = TextEditingController();
  TextEditingController uPasswordController = TextEditingController();

  void careTakerRequest(BuildContext context) async {
    showProgressLoader(context);
    try {
      final response = await rieUserApiService.postApiCall(
          endPoint: AppUrls.careTakerLogin,
          bodyParams: {
            "phone": unameController.text,
            "password": uPasswordController.text,
          },
          fromLogin: true);
      cancelLoader();
      if (response['message'] == 'failure') {
        log('Invalid Credential');
      } else {
        ctModel = CareTakerLoginModelNew.fromJson(response['data']);
        GetStorage().write(Constants.isLogin, true);
        GetStorage().write(Constants.callSync, ctModel?.callSync);
        GetStorage().write(Constants.token, ctModel?.token.toString());
        GetStorage().write(Constants.userId, ctModel?.userId.toString());
        GetStorage().write(Constants.propertyId, jsonEncode(ctModel?.propertyId));
        GetStorage().write(Constants.phonekey, '${ctModel?.phone}');
        GetStorage().write(Constants.profileUrl, '${ctModel?.image}');
        GetStorage().write(Constants.usernamekey, '${ctModel?.name}');
        GetStorage().write(Constants.emailkey, '${ctModel?.email}');
        GetStorage().write(Constants.rolekey, '${ctModel?.role}');


        Get.offAll(const MainPage());
      }
    } on Exception catch (error) {
      RIEWidgets.getToast(message: error.toString(), color: CustomTheme.white);
    }
  }
}
