import 'dart:developer';

import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../theme/custom_theme.dart';
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
  }

  @override
  void dispose() {
    controller.ticketDescription.text = '';
    controller.ticketPropertiesList?.clear();
    controller.ticketCategoriesList?.clear();
    controller.ticketStatusList?.clear();
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
          child: Text(' Ticket '),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(text: 'Ticket Id :  ${data?.id}'),
                            customText(
                                text:
                                    'Status : ${data?.status.toString().capitalizeFirst}'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customText(text: 'Flat Name :  ${data?.unitId}'),
                        const SizedBox(
                          height: 10,
                        ),
                        customText(text: 'Category :  ${data?.category}'),
                        const SizedBox(
                          height: 10,
                        ),
                        customText(
                            text:
                                'Created On : ${dateConvert('${data?.createdOn}')}'),
                        const SizedBox(
                          height: 10,
                        ),
                       /* customText(
                            text:
                                'Updated On : ${dateConvert('${data?.updatedOn}')}'),

                        const SizedBox(
                          height: 10,
                        ),*/
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
                        TextFieldWithTitle(
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
                        ),
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
                            items: /*controller.ticketPropertiesList.map((items) {
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
                        GestureDetector(
                          onTap: () async {
                            int res = await controller.updateTicket(
                                ticketId: '${data?.id.toString()}',
                                flatId: '${data?.unitId.toString()}',
                                ticketCate: '${data?.category.toString()}',
                                ticketDesc: controller.ticketDescription.text,
                                ticketStat:
                                    controller.selectedStatus.toString());
                            RIEWidgets.getToast(
                                message: res == 200
                                    ? 'Ticket Updated Successfully'
                                    : 'Failed to Update',
                                color: Colors.white);
                            Get.back();
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container
                                (
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
                            ],
                          ),
                        ),
                      ],
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
