import 'dart:developer';

import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const/cached_image_placeholder.dart';
import '../../../utils/const/image_view.dart';
import '../../../utils/view/custom_textField_title.dart';
import '../controller/get_all_ticket_controller.dart';
import '../model/ticket_config_model.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  Properties? selectedPropertyy;

  String? selectedCategoryy;

  String? selectedStatuss;

  Flats? selectedFlats;

  AllTicketController controller = Get.find();

  @override
  void dispose() {
    super.dispose();
    controller.selectedProperty = selectedPropertyy;
    controller.selectedCategory = selectedCategoryy;
    controller.selectedStatus = selectedStatuss;
    controller.ticketDescription.text = '';
    controller.selectedFlats = selectedFlats;
    controller.flatsList?.clear();
    controller.ticketImgUrl.clear();
    controller.ticketPropertiesList?.clear();
    controller.ticketCategoriesList?.clear();
    controller.ticketStatusList?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Text('Create Ticket ',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                'Choose Property',
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
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<Properties>(
                  autofocus: true,
                  borderRadius: BorderRadius.circular(20),
                  isExpanded: true,
                  underline: SizedBox(),
                  hint: Text('Selcet Property'),
                  onChanged: (property) {
                    setState(() {
                      controller.selectedProperty = property;
                      controller.selectedFlats = selectedFlats;
                      controller.flatsList = property?.flats;
                    });
                    log('selected property ${controller.selectedProperty?.title.toString()}');
                  },
                  value: controller.selectedProperty,
                  items:
                      /*controller.ticketPropertiesList.map((items) {
              return DropdownMenuItem<String>(

                value: items.toString(),

                child: Text(items.toString()),

              );

            }).toList(),*/
                      controller.ticketPropertiesList
                          ?.map<DropdownMenuItem<Properties>>(
                              (Properties prop) {
                    return DropdownMenuItem<Properties>(
                      value: prop,
                      child: Row(
                        children: [
                          Text('${prop.value} ${prop.title}'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              controller.flatsList != null && controller.flatsList!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const SizedBox(height: 20),
                          Text(
                            'Choose Flat',
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
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButton<Flats>(
                              autofocus: true,
                              borderRadius: BorderRadius.circular(20),
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Text('Selcet Flat'),
                              onChanged: (flats) {
                                setState(
                                    () => controller.selectedFlats = flats);

                                log('selected flats ${controller.selectedFlats?.title.toString()}');
                              },
                              value: controller.selectedFlats,
                              items:
                                  /*controller.ticketPropertiesList.map((items) {

              return DropdownMenuItem<String>(

                value: items.toString(),

                child: Text(items.toString()),

              );

            }).toList(),*/
                                  controller.flatsList
                                      ?.map<DropdownMenuItem<Flats>>(
                                          (Flats flats) {
                                return DropdownMenuItem<Flats>(
                                  value: flats,
                                  child: Row(
                                    children: [
                                      Text('${flats.value} ${flats.title}'),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ])
                  : Container(),
              const SizedBox(height: 20),
              Text(
                'Choose Category',
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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: DropdownButton<String>(
                  underline: SizedBox(),
                  isExpanded: true,
                  hint: Text('Selcet Category'),
                  onChanged: (category) {
                    setState(() => controller.selectedCategory = category);

                    log('selected category ${controller.selectedCategory.toString()}');
                  },
                  value: controller.selectedCategory,
                  items:

                      /*controller.ticketPropertiesList.map((items) {

              return DropdownMenuItem<String>(

                value: items.toString(),

                child: Text(items.toString()),

              );

            }).toList(),*/

                      controller.ticketCategoriesList
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
              const SizedBox(height: 8),
              TextFieldWithTitle(
                title: 'Ticket  Description',
                controller: controller.ticketDescription,
                inputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ticket description';
                  } else {
                    return null;
                  }
                },
              ),
              Text(
                'Choose Status',
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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  hint: Text('Selcet Status'),
                  isExpanded: true,
                  onChanged: (status) {
                    setState(() => controller.selectedStatus = status);
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
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    await controller.updateTicketImg(context);
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
              ),
              Obx(() =>Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  child: ListView.builder(
                      itemCount: controller.ticketImgUrl.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        log('lenght ${index} ${controller.ticketImgUrl[index]}');
                        var data = controller.ticketImgUrl[index];
                       // controller.update();
                        return GestureDetector(
                          onTap: () async {
                       //     await controller.updateTicketImg(context);
                            Get.to(
                                ImageView(profileUrl: '${controller.ticketImgUrl[index]}',)
                            );

                          },
                          child: Container(
                            height: Get.height*0.25,
                            width: Get.height*0.21,
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
                        /*  GestureDetector(
                            onTap: () async{ await controller.updateTicketImg(context);
                            log("hello ${controller.ticketImage}",);
                            setState(() {

                            });
                            },
                          child: Container(
                            height: Get.height*0.25,
                            width: Get.width*0.35,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:controller.ticketImgUrl[index].isNotEmpty && controller.ticketImage.path.isEmpty? NetworkImage(controller.ticketImgUrl[index].toString()):const AssetImage('assets/images/add_images.png',)as ImageProvider<Object>,
                               /* controller.ticketImgUrl[index].isNotEmpty && controller.ticketImage.path.isEmpty
                                    ? const AssetImage('assets/images/add_images.png',)
                                    : FileImage(controller.ticketImage)
                                as ImageProvider<Object>*/
                              ),
                            ),
                          ),
                        );*/
                      }),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    if (controller.selectedProperty?.value == null) {
                      RIEWidgets.getToast(
                          message: 'Please Select Property',
                          color: CustomTheme.white);
                      return;
                    }
                    if (controller.selectedProperty?.value == null) {
                      RIEWidgets.getToast(
                          message: 'Please Select Category',
                          color: CustomTheme.white);
                      return;
                    }
                    if (controller.selectedProperty?.value == null) {
                      RIEWidgets.getToast(
                          message: 'Please Enter description about the ticket',
                          color: CustomTheme.white);
                      return;
                    }
                    if (controller.selectedCategory == null ||
                        controller.selectedCategory == '') {
                      RIEWidgets.getToast(
                          message: 'Please Select tickets Category',
                          color: CustomTheme.white);
                      return;
                    }
                    await controller.createTicket(
                        propertyId:
                            '${controller.selectedProperty?.value.toString()}',
                        flatId: '${controller.selectedFlats?.value.toString()}',
                        ticketCate: controller.selectedCategory.toString(),
                        ticketDesc: controller.ticketDescription.text,
                        ticketStat: controller.selectedStatus.toString(),
                        );
                    Get.back();
                  },
                  child:
                  Container(
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
                      "Create Ticket",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
