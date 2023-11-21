// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:caretaker/models/ot_ticketModel.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/custom_theme.dart';
import '../utils/const/api.dart';
import '../utils/const/app_urls.dart';
import '../utils/const/appbar_widget.dart';
import '../utils/const/widgets.dart';
import 'ticket_solve_module.dart';

class OtTicketsPage extends StatefulWidget {
  const OtTicketsPage({super.key});

  @override
  State<OtTicketsPage> createState() => _OtTicketsPageState();
}

class _OtTicketsPageState extends State<OtTicketsPage> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //pull re
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get _stream => _controller.stream;
  late Future<List<CTTicketModel>> futureAllTickets;
  // XFile? _image;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> imageList = [];
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    futureAllTickets = fetchTicketApi(false);
    super.initState();
  }

//fetch stock
  Future<List<CTTicketModel>> fetchTicketApi(bool isRefresh) async {
    //var sharedPreferences = await _prefs;
    // var list = await allOTTicketGet(
    //     sharedPreferences.getString(Constants.userId).toString());
    if (isRefresh) {
      setState(() {});
    }
    return Future.value([]);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    futureAllTickets = fetchTicketApi(true);
    await Future<void>.delayed(const Duration(seconds: 3));
    _controller.sink.add(SwipeRefreshState.hidden);
  }

  Widget listOtTicket(List<CTTicketModel> ticketList) {
    return ListView.builder(
      itemCount: ticketList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return expandItemTicket(ticketList[i]);
      },
    );
  }

  Widget expandItemTicket(CTTicketModel otTicketModel) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            otTicketModel.ticket,
            style: TextStyle(fontFamily: Constants.fontsFamily),
          ),
          subtitle: Text(
            otTicketModel.resolved.toUpperCase(),
            style: TextStyle(
                fontFamily: Constants.fontsFamily, color: Colors.amber),
          ),
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(5),
          tilePadding: const EdgeInsets.all(5),
          children: [
            Text(
              otTicketModel.comments,
              style: TextStyle(fontFamily: Constants.fontsFamily),
            ),
            Text(
              otTicketModel.resolved,
              style: TextStyle(fontFamily: Constants.fontsFamily),
            ),
            Text(
              convertToAgo(otTicketModel.createdOn),
              style: TextStyle(fontFamily: Constants.fontsFamily),
            ),
            otTicketModel.resolveImg.isNotEmpty
                ? GridView.builder(
                    itemCount: otTicketModel.resolveImg.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenHeight * 0.010,
                        mainAxisSpacing: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return imgLoadWid(
                          AppUrls.imagesRootUrl +
                              otTicketModel.resolveImg[index],
                          assetImg,
                          screenHeight * 0.12,
                          screenWidth * 0.25,
                          BoxFit.cover,
                          0);
                      // return CachedNetworkImage(
                      //   imageUrl: AppConfig.imagesRootUrl +
                      //       otTicketModel.resolveImg[index],
                      //   imageBuilder: (context, imageProvider) => Container(
                      //       height: screenHeight * 0.12,
                      //       width: screenWidth * 0.25,
                      //       decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //               image: imageProvider, fit: BoxFit.cover))),
                      //   placeholder: (context, url) => Center(child: loading()),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),
                      // );
                    },
                  )
                : const SizedBox(),
            Visibility(
              visible: otTicketModel.resolveDescription != 'NA',
              child: Text(
                otTicketModel.resolveDescription,
                style: TextStyle(fontFamily: Constants.fontsFamily),
              ),
            ),
            otTicketModel.resolveImg.isEmpty
                ? Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton.extended(
                      label: titleClr(
                          'Resolve', 10, Colors.white, FontWeight.bold),
                      onPressed: () async {
                        //showModelSheet(context, otTicketModel);
                        dynamic result = await pushNewScreen(context,
                            screen: TicketSolve(
                              tModel: null,
                              otModel: otTicketModel,
                            ),
                            withNavBar: false);
                        if (result.toString().isNotEmpty) {
                          futureAllTickets = fetchTicketApi(true);
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    if (imageFileList != null && imageFileList!.isNotEmpty) {
      for (var img in imageFileList!) {
        if (!imageList.contains(img.name)) {
          String imgv = await uploadImage(img.path, img.name);
          imageList.add(imgv);
        }
      }
    }
    setState(() {});
  }

  Widget inputFelid(
      String hind, TextEditingController tController, double bottom) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CustomTheme.appTheme,
          border: Border.all(color: const Color.fromARGB(255, 227, 225, 225)),
        ),
        child: TextField(
          controller: tController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              hoverColor: CustomTheme.white,
              hintText: hind,
              border: InputBorder.none),
        ),
      ),
    );
  }

  void ticketRequest(CTTicketModel ticketModel) async {
    try {
      // dynamic result = await otTicketUpdateApi(
      //     ticketModel.id, descriptionController.text, jsonEncode(imageList));
      // if (result['success']) {
      //   futureAllTickets = fetchTicketApi(true);
      //   descriptionController.value = const TextEditingValue(text: '');
      //   imageList = [];
      //   showCustomToast(context, result['message']);
      //   Navigator.pop(context);
      // } else {
      //   showCustomToast(context, result['message']);
      // }
    } on Exception catch (error) {
      Navigator.pop(context);
      showCustomToast(context, error.toString());
    }
  }

  void showModelSheet(BuildContext context, CTTicketModel subPost) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModelState) {
            return SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      children: <Widget>[
                        title('Select Image', 20),
                        OutlinedButton(
                          child: titleClr(
                              '+Add Images',
                              17,
                              CustomTheme.appThemeContrast2,
                              FontWeight.normal),
                          onPressed: () {
                            selectImages();
                          },
                        ),
                        height(0.020),
                        (imageList.isNotEmpty)
                            ? GridView.builder(
                                itemCount: imageList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: screenHeight * 0.010,
                                        mainAxisSpacing: 0),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: imgLoadWid(
                                              AppUrls.imagesRootUrl +
                                                  imageList[index],
                                              assetImg,
                                              screenHeight * 0.12,
                                              screenWidth * 0.25,
                                              BoxFit.cover,
                                              0)
                                          // child: CachedNetworkImage(
                                          //   imageUrl: AppConfig.imagesRootUrl +
                                          //       imageList[index],
                                          //   imageBuilder: (context,
                                          //           imageProvider) =>
                                          //       Container(
                                          //           height: screenHeight * 0.12,
                                          //           width: screenWidth * 0.25,
                                          //           decoration: BoxDecoration(
                                          //               image: DecorationImage(
                                          //                   image: imageProvider,
                                          //                   fit: BoxFit.cover))),
                                          //   placeholder: (context, url) =>
                                          //       Center(child: loading()),
                                          //   errorWidget: (context, url, error) =>
                                          //       const Icon(Icons.error),
                                          // ),
                                          ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                imageList
                                                    .remove(imageList[index]);
                                              });
                                            },
                                            child:
                                                iconWidget('cancel', 23, 23)),
                                      )
                                    ],
                                  );
                                },
                              )
                            : height(0),
                        height(0.020),
                        inputFelid('Description', descriptionController, 5),
                        height(0.020),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomTheme.appTheme,
                            ),
                            onPressed: () {
                              if (imageList.isEmpty) {
                                showCustomToast(context, 'Select valid images');
                              } else if (descriptionController.text.isEmpty) {
                                showCustomToast(
                                    context, 'Enter valid description');
                              } else {
                                ticketRequest(subPost);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 27, right: 27),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                    fontFamily: Constants.fontsFamily,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        height(0.020),
                      ],
                    )));
          });
        });
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
                child: FutureBuilder<List<CTTicketModel>>(
                    future: futureAllTickets,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return listOtTicket(snapshot.data!);
                        } else {
                          return Center(
                              child: Column(
                            children: [
                              height(0.33),
                              const Text('Empty Ticket'),
                            ],
                          ));
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      return loading();
                    }))
          ]),
      // floatingActionButton:
    );
  }
}
