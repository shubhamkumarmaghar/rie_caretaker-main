// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:caretaker/models/ot_ticketModel.dart';
import 'package:caretaker/modules/home/model/ticketModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/custom_theme.dart';
import '../utils/const/api.dart';
import '../utils/const/app_urls.dart';
import '../utils/const/appbar_widget.dart';
import '../utils/const/widgets.dart';

class TicketSolve extends StatefulWidget {
  final TicketModel? tModel;
  final CTTicketModel? otModel;
  const TicketSolve({super.key, required this.tModel, required this.otModel});

  @override
  State<TicketSolve> createState() => _TicketSolveState();
}

class _TicketSolveState extends State<TicketSolve> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // XFile? _image;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> imageList = [];
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          setState(() {
            imgListWidget();
          });
        }
      }
    }
    setState(() {});
  }

  Widget imgListWidget() {
    return GridView.builder(
      itemCount: imageList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: screenHeight * 0.010,
          mainAxisSpacing: 0),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: imgLoadWid(
                    AppUrls.imagesRootUrl + imageList[index],
                    assetImg,
                    screenHeight * 0.12,
                    screenWidth * 0.25,
                    BoxFit.cover,
                    0)
                // child: CachedNetworkImage(
                //   imageUrl: AppConfig.imagesRootUrl + imageList[index],
                //   imageBuilder: (context, imageProvider) => Container(
                //       height: screenHeight * 0.12,
                //       width: screenWidth * 0.25,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: imageProvider, fit: BoxFit.cover))),
                //   placeholder: (context, url) => Center(child: loading()),
                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                // ),
                ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      imageList.remove(imageList[index]);
                    });
                  },
                  child: iconWidget('cancel', 23, 23)),
            )
          ],
        );
      },
    );
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
          color: CustomTheme.appThemeContrast2,
          border: Border.all(color: const Color.fromARGB(255, 227, 225, 225)),
        ),
        child: TextField(
          controller: tController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              hoverColor: CustomTheme.appTheme,
              hintText: hind,
              border: InputBorder.none),
        ),
      ),
    );
  }

  void ticketRequest(TicketModel ticketModel) async {
    try {
      dynamic result = await ticketUpdateApi(
          '${ticketModel.data?.id.toString()}', descriptionController.text, jsonEncode(imageList));
      if (result['success']) {
        descriptionController.value = const TextEditingValue(text: '');
        imageList = [];
        showCustomToast(context, result['message']);
        Navigator.pop(context, 'true');
      } else {
        showCustomToast(context, result['message']);
      }
    } on Exception catch (error) {
      Navigator.pop(context, 'true');
      showCustomToast(context, error.toString());
    }
  }

  void otTicketRequest(CTTicketModel ticketModel) async {
    try {
      // dynamic result = await otTicketUpdateApi(
      //     ticketModel.id, descriptionController.text, jsonEncode(imageList));
      // if (result['success']) {
      //   descriptionController.value = const TextEditingValue(text: '');
      //   imageList = [];
      //   showCustomToast(context, result['message']);
      //   Navigator.pop(context, 'true');
      // } else {
      //   showCustomToast(context, result['message']);
      // }
    } on Exception catch (error) {
      Navigator.pop(context, 'true');
      showCustomToast(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          title: titleClr('Ticket Resolve', 20, Colors.white, FontWeight.bold),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, 'true');
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: CustomTheme.appTheme),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                height(0.020),
                Align(
                    alignment: Alignment.centerLeft,
                    child: title('Select Image', 20)),
                OutlinedButton(
                  child: titleClr('+Add Images', 17,
                      CustomTheme.white, FontWeight.normal),
                  onPressed: () {
                    selectImages();
                  },
                ),
                height(0.020),
                imgListWidget(),
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
                        showCustomToast(context, 'Enter valid description');
                      } else {
                        if (widget.otModel != null) {
                          otTicketRequest(widget.otModel!);
                        } else {
                          ticketRequest(widget.tModel!);
                        }
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
  }
}
