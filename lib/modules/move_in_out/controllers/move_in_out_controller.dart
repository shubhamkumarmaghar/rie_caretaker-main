import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:caretaker/theme/custom_theme.dart';
import 'package:caretaker/utils/const/app_urls.dart';
import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_screen/controller/home_controller.dart';
import '../model/move_in_out.dart';

class MoveInOutController extends GetxController {
 bool isLoading = false;
 HomeController homeController = Get.find();
 MoveInOutModel? moveInOutModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMoveInOutData();
   // getVisitedData();

  }

  ///MoveINOut data
 Future<void> getMoveInOutData() async {
      isLoading = true;
      String url = AppUrls.getMoveInOut;
      final  response = await homeController.apiService.getApiCallWithURL(endPoint: url);
      final data = response as Map<String, dynamic>;
      if (data['message'].toString().toLowerCase().contains('success')) {
        moveInOutModel = MoveInOutModel.fromJson(data);


        isLoading=false;
        update();
      } else {
        moveInOutModel = MoveInOutModel(message: 'failure');

        isLoading=false;
        update();
      }

  }

 Future<bool> moveIN({ required int? bookingId }) async {

   isLoading = true;
   String url = AppUrls.moveIn;
   final  response = await homeController.apiService.postApiCall(
       endPoint: url,
       bodyParams: {'bookingId': bookingId.toString(),
       'date':DateTime.now().toString(),
       }
   );
if(response['message']=='Success'){
  RIEWidgets.getToast(message: "Successfully Move IN", color: CustomTheme.white);
  isLoading = false;
  update();
  return true;
}
else{
  isLoading = false;
  update();
  return false;
}
 }

 Future<bool> moveOUT({ required int? bookingId }) async {

   isLoading = true;
   String url = AppUrls.moveOut;
   final  response = await homeController.apiService.postApiCall(
       endPoint: url,
       bodyParams: {'bookingId': bookingId.toString(),
         'date':DateTime.now().toString(),
       }
   );
   if(response['message']=='Success'){
     RIEWidgets.getToast(message: "Successfully Move Out", color: CustomTheme.white);
     isLoading = false;
     update();
     return true;
   }
   else{
     isLoading = false;
     update();
     return false;
   }
 }

 void showMoveInAlertDialog(BuildContext context , int? bookingId, String MoveInOut,
     ) {
   AwesomeDialog(
     context: context,
     dialogType: DialogType.info,
     animType: AnimType.bottomSlide,
     title: '$MoveInOut ?',
     desc: 'Are you sure you want to $MoveInOut?',
     titleTextStyle: TextStyle(fontSize: 22, color: Colors.black),
     descTextStyle: TextStyle(fontSize: 18, color: Colors.black54),
     btnOkText: "$MoveInOut",
     btnOkOnPress: () async {
       if(MoveInOut == 'Move In')
         {
           bool a = await moveIN(bookingId: bookingId);
           if(a){
             await getMoveInOutData();
           }
         }
       else{
         bool a = await moveOUT(bookingId: bookingId);
         if(a){
           await getMoveInOutData();
         }
       }
       //api.doBlockUnblockPeople(user_id ?? '', status);
     },
     btnCancelText: "Cancel",
     btnCancelOnPress: () {
       // Navigator.pop(context);
     },
   ).show();
 }


/*
 ///visited data
 Future<void> getVisitedData() async {
   try {
     http.Response response = await http.post(
         Uri.parse(API.getViewList),
         headers: {
           'x-access-token': '${GetStorage().read('token')}',
         });

     print("response of visited data ${response.body}");


     if (jsonDecode(response.body)['data']!= null && jsonDecode(response.body)['message'] == 'Data Found') {
       var usersData = jsonDecode(response.body ) as Map<String,dynamic>;
       var data=VisitInfoModel.fromJson(usersData) ;
       var list = data.data ?? [];


       visiteddataModel = data;

       // dynamic decodedData = jsonDecode(response.body);
       // visitorinfo =  decodedData['data'];
       // return decodedData;
update();
     } else {
       print("No data found ${response.body}");
     }
   } on Exception catch (e) {
     print('Exception in Visited data ${e}');
   }
   update();
 }
*/
}
