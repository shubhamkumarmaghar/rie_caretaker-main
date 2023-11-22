import 'dart:developer';
import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../theme/custom_theme.dart';
import '../../../utils/const/app_urls.dart';
import '../../../utils/services/rie_user_api_service.dart';
import '../../../utils/view/rie_widgets.dart';

class HomeController extends GetxController{
  final RIEUserApiService _apiService = RIEUserApiService();
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  List<CallLogEntry> currentlogs = <CallLogEntry>[];
  
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
          /*   RMSWidgets.showSnackbar(
              context: context,
              message: 'success',
              color: CustomTheme.appTheme);*/
        } else {
        /*  
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
      /*  RMSWidgets.showSnackbar(
          context: context,
          message: "Already Updated",
          color: CustomTheme.myFavColor); */
    }
  }

}