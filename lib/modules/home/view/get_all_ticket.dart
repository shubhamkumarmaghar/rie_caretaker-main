import 'dart:developer';

import 'package:caretaker/modules/home/view/view_ticket_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../../../theme/custom_theme.dart';
import '../controller/get_all_ticket_controller.dart';
import '../model/TicketListModel.dart';
import 'create_ticket.dart';

class GetAllTickets extends StatefulWidget {
  const GetAllTickets({super.key});

  @override
  State<GetAllTickets> createState() => _GetAllTicketsState();
}


class _GetAllTicketsState extends State<GetAllTickets> {

  AllTicketController controller = Get.put(AllTicketController());
  @override
  void initState() {
    super.initState();
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
          child: Text('Get All Tickets '),
        ),
      ),
      body: GetBuilder<AllTicketController>(
        init: AllTicketController(),
        builder: (controller) {
          var dataList = controller.getAllDetails.data;
           return controller.isLoading == false ? TicketListScreen(
             dataList: dataList,):
           const Center(child: CircularProgressIndicator.adaptive(),);
              }),
      floatingActionButton: Container(
        width: Get.width*0.35
      ,margin: EdgeInsets.all(10),
        child: FloatingActionButton( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
         onPressed: () async{
           await controller.fetchTicketConfigListDetails();
              Get.to(CreateTicket());
           },
           backgroundColor: CustomTheme.appTheme,
           child: Row(
             children: const [
               Text('   Create Ticket  '),
               Icon(CupertinoIcons.add_circled),
             ],
           ),
         ),
      ),
    );
  }
}

class TicketListScreen extends StatelessWidget {
  AllTicketController ticketController = Get.find();
  TicketListScreen({
    required this.dataList,
  });
  final List<Data>? dataList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList?.length,
      itemBuilder: (context, index) {
        var data = dataList?[index];
        return  GestureDetector(onTap:() async {
          await ticketController.fetchTicketConfigListDetails();
          await ticketController.fetchTicketDetails('${data?.id.toString()}');
          Get.to(ViewTicketDetails());
        },

          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(
                vertical: 10,horizontal: 10
            ),
            decoration: BoxDecoration(
              color: CustomTheme.white,
              border: Border.all(color: CustomTheme.appTheme,
              /*    gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  /*    Color(0xfff2d5f7),
                      Color(0xffe6acef),
                      Color(0xffd982e6),
                      Color(0xffcd59de),
                      Color(0xffc02fd6),*/

                  /*  Color(0xffd1dce6),
                      Color(0xffa2bace),
                      Color(0xff7497b5),
                      Color(0xff45759d),
                      Color(0xff175284),
*/
                  Color(0xffee216c),
                  Color(0xffee216c),
                  Color(0xffee216c),
                  Color(0xfff14d89),
                  Color(0xfff57aa7),
                  Color(0xfff8a6c4),
                  Color(0xfffcd3e2),
                  // Colors.red.shade800,
                  //Colors.red.shade700,
                  //Colors.red.shade500,
                  // Colors.red.shade400,
                  // Colors.red.shade300,
                  // Colors.black45,
                  //Colors.black54,
                  //   Colors.black87,
                  // Colors.black,
                ]

            ),
*/
            ),borderRadius: BorderRadius.circular(10),
              boxShadow: [
              BoxShadow(
              blurRadius: 1,
              color: CustomTheme.skyBlue,blurStyle:BlurStyle.solid ,
              spreadRadius: 1,
            ),
            ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ticket Id : ${data?.id} ',
                              style:
                              TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Flat : ${data?.unit} ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text('Updated on :${dateConvert('${data?.createdOn}')}',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Category ${data?.category} ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text('Updated on :${dateConvert('${data?.updatedOn}')}'
                                  ,
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Added By  :  ${data?.addedBy}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Status  : ${data?.status.toString().capitalizeFirst}',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Description  :  ${data?.description}',maxLines: 3,
                              style: TextStyle(fontSize: 12),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                size: 2.5.h,
                              ),
                              Flexible(
                                child: Text(
                                  'Plan',
                                  style: TextStyle(
                                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),*/
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },);
  }

  String dateConvert(String date){
    String dateTime;
    try{
    if(date.isNotEmpty) {
      DateTime datee = DateTime.parse(date);
      dateTime = DateFormat('dd-MM-yyyy, hh:mm a').format(datee);

    }
    else{
      dateTime='NA';
    }
    }
    catch (e)
    {
      log('error exception ::$e');
      dateTime='NA';
    }
    return dateTime;
  }

}

