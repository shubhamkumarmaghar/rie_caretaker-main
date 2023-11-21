import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallLogs {
  getAvator(CallType callType) {
    switch (callType) {
      case CallType.outgoing:
        return const CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.yellow,
          backgroundColor: Colors.yellowAccent,
        );
      case CallType.missed:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.red[400],
          backgroundColor: Colors.red[400],
        );
      default:
        return const CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.green,
          backgroundColor: Colors.green,
        );
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs(int from) {
    return CallLog.query(
        dateFrom: from, dateTo: DateTime.now().millisecondsSinceEpoch);
  }

  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) return Text(entry.number!);
    if (entry.name!.isEmpty) {
      return Text(entry.number!);
    } else {
      return Text(entry.name!);
    }
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += "${d1.inHours}h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += "${d1.inMinutes}m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += "${d1.inSeconds}s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
