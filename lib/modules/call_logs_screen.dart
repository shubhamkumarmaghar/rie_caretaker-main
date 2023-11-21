import 'dart:async';

import 'package:call_log/call_log.dart';
import 'package:caretaker/call_logs/call_logs.dart';
import 'package:flutter/material.dart';

import '../theme/custom_theme.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  //call-logs
  CallLogs cl = CallLogs();
  late Future<Iterable<CallLogEntry>> logs;

  @override
  void initState() {
    logs = cl.getCallLogs(DateTime.now().millisecondsSinceEpoch);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: FloatingActionButton(
              backgroundColor: CustomTheme.appTheme,
              child: const Center(
                  child: Icon(
                Icons.sync,
                size: 20,
                color: Colors.white,
              )),
              onPressed: () {
                logs = cl.getCallLogs(DateTime.now()
                    .subtract(const Duration(days: 1))
                    .millisecondsSinceEpoch);
              },
            )),
        body: FutureBuilder(
            future: logs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Iterable<CallLogEntry> entries = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: SizedBox(
                              height: 20,
                              width: 10,
                              child: cl.getAvator(
                                  entries.elementAt(index).callType!)),
                          title: cl.getTitle(entries.elementAt(index)),
                          subtitle: Text(
                              "${cl.formatDate(DateTime.fromMillisecondsSinceEpoch(entries.elementAt(index).timestamp!))}\n${cl.getTime(entries.elementAt(index).duration!)}"),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  },
                  itemCount: entries.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
