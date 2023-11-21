import 'dart:async';
import 'dart:convert';
import 'package:caretaker/models/property_model_new.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../../utils/const/api.dart';
import '../../../utils/const/app_urls.dart';
import '../../../utils/const/appbar_widget.dart';
import '../../../utils/const/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //pull re
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get _stream => _controller.stream;
  late Future<PropertyModelNew?> futureAllHouse;

  @override
  void initState() {
    futureAllHouse = fetchHouseApi();
    super.initState();
  }

  //fetch stock
  Future<PropertyModelNew?> fetchHouseApi() async {
    var sharedPreferences = await _prefs;
    List<dynamic> li = jsonDecode(
        GetStorage().read(Constants.propertyId));
    if (li.isNotEmpty) {
      PropertyModelNew? proM = await allPropertyGet(li.last.toString());
      return proM;
    }
    return null;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    futureAllHouse = fetchHouseApi();
    await Future<void>.delayed(const Duration(seconds: 3));
    _controller.sink.add(SwipeRefreshState.hidden);
  }

  Widget listStock(PropertyModelNew stockList) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return expandItemHouse(stockList);
      },
    );
  }

  Widget expandItemHouse(PropertyModelNew proModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ExpansionTile(
            leading: imgLoadWid(proModel.images.first.replaceAll('.webp', ''),
                assetImg, 100, 100, BoxFit.contain, 10),
            title: Text(
              proModel.name,
              style: TextStyle(fontFamily: Constants.fontsFamily),
            ),
            subtitle: Text(
              'House Id: ${proModel.id}',
              style: TextStyle(fontFamily: Constants.fontsFamily),
            ),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(5),
            tilePadding: const EdgeInsets.all(5),
            children: [
              title('House Details', 10),
              titleClr(proModel.address, 13, Colors.black.withOpacity(0.50),
                  FontWeight.normal),
              titleClr(proModel.facility, 13, Colors.black.withOpacity(0.50),
                  FontWeight.normal),
              // titleClr(proModel.status, 13, Colors.green.withOpacity(0.50),
              //     FontWeight.normal),
              title('Property Details', 10),
              titleClr(proModel.type, 13, Colors.black.withOpacity(0.50),
                  FontWeight.normal),
              // titleClr(proModel.plots, 13, Colors.black.withOpacity(0.50),
              //     FontWeight.normal),
              titleClr(proModel.address, 13, Colors.black.withOpacity(0.50),
                  FontWeight.normal),
              titleClr('Plots : ${proModel.plots}', 13,
                  Colors.black.withOpacity(0.50), FontWeight.normal),
              titleClr('Floor : ${proModel.floor}', 13,
                  Colors.black.withOpacity(0.50), FontWeight.normal),
              titleClr('Type : ${proModel.type}', 13,
                  Colors.black.withOpacity(0.50), FontWeight.normal),
              titleClr('City : ${proModel.city}', 13,
                  Colors.black.withOpacity(0.50), FontWeight.normal),
              titleClr('BhkType : ${proModel.bhkType}', 13,
                  Colors.black.withOpacity(0.50), FontWeight.normal)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SwipeRefresh.material(
            stateStream: _stream,
            onRefresh: _refresh,
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 50),
              child: FutureBuilder<PropertyModelNew?>(
                  future: futureAllHouse,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return listStock(snapshot.data!);
                      } else {
                        return Center(
                            child: Column(
                          children: [
                            height(0.33),
                            const Text('Empty House Details'),
                          ],
                        ));
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    return loading();
                  }))
        ]));
  }
}
