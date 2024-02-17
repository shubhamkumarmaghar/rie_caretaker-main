import 'dart:developer';
import 'dart:io';
import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../../../theme/custom_theme.dart';
import '../../../utils/const/app_urls.dart';
import '../../../utils/services/rie_user_api_service.dart';
import '../../../utils/view/rie_widgets.dart';

class HomeController extends GetxController{
  final RIEUserApiService apiService = RIEUserApiService();
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  List<CallLogEntry> currentlogs = <CallLogEntry>[];
  bool isLoading = true;
  RxBool logValue = false.obs;
  bool singleTap = true;
  @override
  void onInit() {
  getdata();
    super.onInit();
  }

  void getdata ()async{
    var phone = await GetStorage().read(Constants.phonekey);
    if(await GetStorage().read(Constants.callSync)==1 && phone != null) {
      log("second logs logs 1");
      await getLastCallTimestamp();
//    Workmanager().initialize(callbackDispatcher, isInDebugMode: false,);
      // await callbackDispatcher();
      try {
        if (Platform.isAndroid) {
          Workmanager().registerPeriodicTask('1', 'GetApiData',
              initialDelay: const Duration(seconds: 10),
              inputData: {'mobile': GetStorage().read(Constants.phonekey)},
              existingWorkPolicy: ExistingWorkPolicy.append);
        }
        else{
          Workmanager().registerOneOffTask(
              "1",
              'GetApiData', // Ignored on iOS
              initialDelay: Duration(seconds: 10),
              constraints: Constraints(
                // connected or metered mark the task as requiring internet
                networkType: NetworkType.connected,
                // require external power
               // requiresCharging: true,
              ),
              inputData: {'mobile': GetStorage().read(Constants.phonekey)},

            // fully supported
          );
        }
      }
      catch(e)
    {
      log("background running task $e");
    }
    }
  }

  Future<void> callbackDispatcher() async {
    Workmanager().executeTask((taskName, inputData) async {
      // userLocation();
      if (taskName == 'GetApiData') {
        String mobileNo= inputData != null ? inputData['mobile'] : '';
        await callLogs(lastdate: GetStorage().read(Constants.lastCallStamp) );
      }
      return Future.value(true);
    });
  }

  Future callLogs({required String? lastdate,
    }) async
  {
    DateTime lastDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(lastdate ?? DateTime.now().toLocal().toString());
    final Iterable<CallLogEntry> result = await CallLog.query();
    _callLogEntries = result;
    for (CallLogEntry entry in _callLogEntries) {
      var timestamp = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)
          .toString()
          .split('.');

      DateTime calltime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(timestamp[0]);

      if (calltime.isAfter(lastDate)) {
        log("length $timestamp---- $calltime  $lastdate " );
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
           // callduration = '0';
            break;
          case CallType.rejected:
           /// callType = "missed";
            callType = "rejected";
          //  callduration = '0';
            break;

          case CallType.voiceMail:
            callType = "incoming";
            // TODO: Handle this case.
            break;
          case CallType.blocked:
            callType = "missed";
            // TODO: Handle this case.
            break;
          case CallType.answeredExternally:
            callType = "missed";
            // TODO: Handle this case.
            break;
          case CallType.unknown:
            callType = "missed";
            // TODO: Handle this case.
            break;
          case CallType.wifiIncoming:
            callType = "incoming";
            // TODO: Handle this case.
            break;
          case CallType.wifiOutgoing:
            callType = "outgoing";
            // TODO: Handle this case.
            break;
          default:
            callType = "missed";
        }
        String url = AppUrls.uploadCallLogs;
        final response = await apiService.postApiCall(endPoint: url,
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
          String callLast =calldate[0].replaceRange(10, 11, ' ');
          GetStorage().write(Constants.lastCallStamp,callLast );
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
    singleTap = true;
  }

  Future<void> getLastCallTimestamp() async {
    String url = AppUrls.getLastCallTimestamp;
    url = '$url?staffPhone=${GetStorage().read(Constants.phonekey)}';
    isLoading = true;
    final response = await apiService.getApiCallWithURL(endPoint: url);
    final data = response as Map<String, dynamic>;
    if (data['message'].toString().toLowerCase().contains('success') && data['data'] != null ) {
    var lastCall  = data['data']['date'];
    if(lastCall != null || lastCall != "") {
      GetStorage().write(Constants.lastCallStamp, lastCall.replaceRange(10, 11, ' '));
      String date = GetStorage().read(Constants.lastCallStamp);
      log('xoxo :: $date  ${date.replaceRange(10, 11, ' ')}');
    }
    else{
      String date =  DateTime.now().subtract(const Duration(days: 2)).toString();
      GetStorage().write(Constants.lastCallStamp, date);
    }

    isLoading = false;

    update();
    } else {
      isLoading=false;
      update();
    }

  }

}