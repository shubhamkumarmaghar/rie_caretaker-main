import 'dart:developer';

import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/custom_theme.dart';
import '../../../utils/const/cached_image_placeholder.dart';
import '../../../utils/const/image_view.dart';
import '../../../utils/view/custom_textField_title.dart';
import '../controller/get_all_ticket_controller.dart';

class ViewTicketDetails extends StatefulWidget {
  const ViewTicketDetails({super.key});

  @override
  State<ViewTicketDetails> createState() => _ViewTicketDetailsState();
}

class _ViewTicketDetailsState extends State<ViewTicketDetails> {
  AllTicketController controller = Get.find();

  //var data;
  @override
  void initState() {
    super.initState();
    // data = controller.getSingleTicketDetails.data;
    controller.ticketDescription.text =
        '${controller.getSingleTicketDetails.data?.description}';
    controller.selectedStatus =
        '${controller.getSingleTicketDetails.data?.status}';
    controller.getSingleTicketDetails.data?.proofs?.forEach((element) {
      controller.ticketImgUrl.add('${element.url}');
    });
  }

  @override
  void dispose() {
    controller.ticketDescription.text = '';
    controller.ticketPropertiesList?.clear();
    controller.ticketCategoriesList?.clear();
    controller.ticketStatusList?.clear();
    controller.ticketImgUrl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = controller.getSingleTicketDetails.data;
    return Scaffold(
      backgroundColor: CustomTheme.appTheme4,
      appBar: AppBar(
        leading: BackButton(
          color: CustomTheme.white,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        titleSpacing: -10,
        backgroundColor: CustomTheme.appTheme,
        title: Padding(
          padding: EdgeInsets.all(10),
          child: Text(' Ticket Id : ${data?.id}',style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  color: CustomTheme.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: Get.height*0.5,
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                  text:
                                  'Created On : ${dateConvert('${data?.createdOn}')}'),
                              customText(
                                  text:
                                      'Status : ${data?.status.toString().capitalizeFirst}'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(text: 'Flat Name :  ${data?.unitId}'),
                              customText(text: 'Category :  ${data?.category}'),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          customText(text: 'Description : ${data?.description}'),
                          const SizedBox(
                            height: 10,
                          ),/*
                          customText(
                              text:
                                  'Reminds On : ${dateConvert('${data?.remindOn.toString()}')}'),
                          const SizedBox(
                            height: 10,
                          ),
                          customText(
                              text:
                                  'Closed On : ${dateConvert('${data?.closedOn.toString()}')}'),*/
                          //  const SizedBox(height: 10,),
                         /* TextFieldWithTitle(
                            title: 'Update Ticket Description',
                            controller: controller.ticketDescription,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an Updated ticket description';
                              } else {
                                return null;
                              }
                            },
                          ),*/
                          const SizedBox(height: 8),
                          const Text(
                            'Update Status',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'malgun',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.center,
                            // margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: CustomTheme.appTheme4,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),

                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              hint: Text('Selcet Status'),
                              isExpanded: true,
                              onChanged: (status) {
                                setState(
                                    () => controller.selectedStatus = status);
                                log('selected status ${controller.selectedStatus}');
                              },
                              value: controller.selectedStatus,
                              items:
                              /*controller.ticketPropertiesList.map((items) {
                                    return DropdownMenuItem<String>(
                                      value: items.toString(),
                                      child: Text(items.toString()),
                                    );
                                  }).toList(),*/

                                  controller.ticketStatusList
                                      ?.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(() => Container(
                              width: Get.width,
                              height: Get.height * 0.2,
                              child: ListView.builder(
                                  itemCount: controller.ticketImgUrl.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    log('lenght ${index} ${controller.ticketImgUrl[index]}');
                                    var data = controller.ticketImgUrl[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        Get.to(
                                            ImageView(profileUrl: '${controller.ticketImgUrl[index]}',)
                                        );
                                      //  await controller.updateTicketImg(context);
                                      },
                                      child: Container(
                                          height: Get.height*0.15,
                                          width: Get.height*0.2,
                                          child:Card(shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              topLeft: Radius.circular(15.0),
                                              bottomLeft: Radius.circular(15.0),
                                            ),
                                          ),
                                            clipBehavior: Clip.hardEdge,
                                            child: CachedNetworkImageWidget(
                                                imageUrl: data,
                                                width: Get.height*0.25,
                                                height: Get.height*0.21,
                                                fit: BoxFit.fill,
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Center(
                                                      child:  Card(
                                                        color: Colors.red.shade50,
                                                        child: Lottie.asset(
                                                          'assets/images/add_images.json',
                                                        ),
                                                        /* CupertinoActivityIndicator(
                                                    radius: 15,
                                                    color: Colors.black,
                                                  ),*/
                                                      ),),
                                                placeholder: (context, url) =>
                                                const Center(
                                                    child: CupertinoActivityIndicator(
                                                        color: Colors
                                                            .black,
                                                        radius: 15))
                                            ),
                                          )
                                      ),
                                    );

                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await controller.updateTicketImg(context);
                                  log(
                                    "hello ${controller.ticketImage}",
                                  );
                                  log('${controller.ticketImgUrl.length}');
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.04,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.orange,
                                  ),
                                  child: FittedBox(
                                      child: Text(
                                        "Add Images",
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  int res = await controller.updateTicket(
                                      ticketId: '${data?.id.toString()}',
                                      flatId: '${data?.unitId.toString()}',
                                      propId: '${data?.propId.toString()}',
                                      ticketCate: '${data?.category.toString()}',
                                      ticketDesc: controller.ticketDescription.text,
                                      ticketStat: controller.selectedStatus.toString());
                                  RIEWidgets.getToast(
                                      message: res == 200
                                          ? 'Ticket Updated Successfully'
                                          : 'Failed to Update',
                                      color: Colors.white);
                                  Get.back();
                                },
                                child: Container(
                                      width: Get.width * 0.3,
                                      height: Get.height * 0.04,
                                      padding: const EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.orange,
                                      ),
                                      child: const FittedBox(
                                          child: Text(
                                        "Update Ticket",
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 16),
                                      )),
                                    ),

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            SizedBox(height: Get.height*0.4,
              child: Card(
                color: CustomTheme.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                child: Padding(padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
    itemCount: data?.followUps?.length,
    itemBuilder: (context, index) {
      var data1 = data?.followUps?[index];
      return Container(
        margin: const EdgeInsets.only(top: 5),
          child: Text('${dateConvert('${data1?.addedOn}')} (${data1?.addedBy}): ${data1?.followUp}'));
    }),


                ),
              ),
            ),
               /* GestureDetector(
                  onTap: () async {
                    int res = await controller.updateTicket(
                        ticketId: '${data?.id.toString()}',
                        flatId: '${data?.unitId.toString()}',
                        ticketCate: '${data?.category.toString()}',
                        ticketDesc: controller.ticketDescription.text,
                        ticketStat: controller.selectedStatus.toString());
                    RIEWidgets.getToast(
                        message: res == 200
                            ? 'Ticket Updated Successfully'
                            : 'Failed to Update',
                        color: Colors.white);

                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.3,
                    height: Get.height * 0.04,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange,
                    ),
                    child: FittedBox(
                        child: Text(
                      "Update Ticket",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ),*/
              ],
            )),
      ),
    );
  }

  Widget customText(
      {required String text,
      double size = 14,
      int maxLine = 1,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }

  String dateConvert(String date) {
    String dateTime;
    try {
      if (date.isNotEmpty) {
        DateTime datee = DateTime.parse(date);
        dateTime = DateFormat('dd-MM-yyyy, hh:mm a').format(datee);
      } else {
        dateTime = 'NA';
      }
    } catch (e) {
      log('error exception ::$e');
      dateTime = 'NA';
    }
    return dateTime;
  }
}
