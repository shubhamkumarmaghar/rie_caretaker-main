// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:caretaker/modules/login/login_screen.dart';
import 'package:caretaker/theme/custom_theme.dart';
import 'package:caretaker/utils/const/app_urls.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';
import 'modules/main_screen/controller/home_controller.dart';
import 'modules/main_screen/view/main_screen.dart';



@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
 await GetStorage.init();
  Workmanager().executeTask((taskName, inputData) async {
    // userLocation();
    log("first logs 1");
  await homeController.getLastCallTimestamp();
    if (taskName == 'GetApiData') {
      String mobileNo= inputData != null ? inputData['mobile'] : '';
      String date;
      if(GetStorage().read(Constants.lastCallStamp)==null){
      date =  DateTime.now().subtract(const Duration(days: 2)).toString();
      GetStorage().write(Constants.lastCallStamp,date);
      log('date $date');
      }
      else{
        date = GetStorage().read(Constants.lastCallStamp);
      }

      await homeController.callLogs(lastdate: date );
    }
    return Future.value(true);
  });
}
HomeController homeController = HomeController();

/*
Future calllogs({required String? lastdate,
}) async
{
  DateTime lastDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(lastdate !=null?lastdate:DateTime.now().toLocal().toString());
  final Iterable<CallLogEntry> result = await CallLog.query();
  log('all data ${_callLogEntries.toString()}');
  _callLogEntries = result;
  for (CallLogEntry entry in _callLogEntries) {
    var timestamp = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)
        .toString()
        .split('.');

    DateTime calltime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(timestamp[0]);

    if (calltime.isAfter(lastDate)) {
      log("length ${timestamp}---- ${calltime}");
      //  if (DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)
      //.isAfter(DateTime.now().toLocal().subtract(Duration(days: 1)))) {
      log('checking ${calltime.toString()} -- ${lastdate.toString()}');
      currentlogs.add(entry);
    }
  }
  log("length ${currentlogs.length}");

  if (currentlogs.length > 0) {
    for (int i = currentlogs.length - 1; i >= 0; i--) {
      var calldate =
      DateTime.fromMillisecondsSinceEpoch(currentlogs[i].timestamp ?? 0)
          .toString()
          .split('.');
      String callType = "";
      CallType? calltype = currentlogs[i].callType;
      String callduration = currentlogs[i].duration.toString();
      switch (calltype) {
        case CallType.outgoing:
          callType = "outgoing";
          break;
        case CallType.incoming:
          callType = "incoming";
          break;
        case CallType.missed:
          callType = "missed";
          callduration = '0';
          break;
        case CallType.rejected:
          callType = "rejected";
          callduration = '0';
          break;
      }
      String url = AppUrls.uploadCallLogs;
      final response = await _apiService.postApiCall(endPoint: url,
          bodyParams:
          {
            'staffPhone': GetStorage().read(Constants.phonekey).toString(),
            'leadPhone': currentlogs[i].number.toString(),
            'callType': callType.toString(),
            'date': calldate[0].toString(),
            'duration': callduration.toString(),
          }
      );
      final data = response as Map<String, dynamic>;
      if (data['message'].toString().toLowerCase().contains('success')) {
        log('Success data went to server');
        GetStorage().write(Constants.lastCallStamp,calldate[0].toString() );
        RIEWidgets.getToast(message: '${currentlogs[i].number} updated to the server', color: CustomTheme.white);
        /*   RMSWidgets.showSnackbar(
              context: context,
              message: 'success',
              color: CustomTheme.appTheme);*/
      } else {
        RIEWidgets.getToast(message: 'Something Went Wrong.', color: CustomTheme.white);
        /*\
          RIEWidgets.showSnackbar(
              context: context,
              message: 'Something Went Wrong.',
              color: CustomTheme.errorColor);
              */
        log('Something Went Wrong.');
      }
    };
    currentlogs.clear();
  } else {
    log('call log alreday updated');
    RIEWidgets.getToast(message: 'call log alreday updated', color: CustomTheme.white);
    /*  RMSWidgets.showSnackbar(
          context: context,
          message: "Already Updated",
          color: CustomTheme.myFavColor); */
  }
}
*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await GetStorage.init();
  //Workmanager().initialize(callbackDispatcher, isInDebugMode: false,);
  _portraitModeOnly();
   await function();
  runApp(const MyApp());
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
 Future<void> function() async{
   if(await GetStorage().read(Constants.callSync)==1){
   if(await GetStorage().read(Constants.isLogin)==true) {
     await Workmanager().cancelAll();
     await Workmanager().initialize(callbackDispatcher, isInDebugMode: false,);
     await GetStorage().write(Constants.background, true);
   }
     //homeController.getdata();
   }
  await GetStorage().write(Constants.background, false);

 }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context,child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9), child: child ?? const Text(''));
      },
      title: 'RENTISEASY ADMIN',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        primaryColor: CustomTheme.appTheme,

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

  @override
  void initState() {
    goToSplash();
    getPermissionUser();
    super.initState();
  }

  void goToSplash() async {
    Timer(const Duration(seconds: 3), () async {
    //  var sharedPreferences = await _prefs;
      if(GetStorage().read(Constants.isLogin) == null){
       // GetStorage().write(Constants.isLogin, false);
        String date =  DateTime.now().subtract(const Duration(days: 2)).toString();
        GetStorage().write(Constants.lastCallStamp, date);
       // GetStorage().write(Constants.lastCallStamp,);
      }
        if (GetStorage().read(Constants.isLogin)== true ) {
          debugPrint('0000 ${GetStorage().read(Constants.isLogin)}');
          Get.offAll(const MainPage());
        } else {
          debugPrint('1111 ${GetStorage().read(Constants.isLogin)} ');
          Get.offAll(LoginScreen());
        }

    });
  }

  void getPermissionUser() async {
    if (await Permission.phone.request().isGranted) {
      log('Permission Granted');
    } else {
      await Permission.phone.request();
    }
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
