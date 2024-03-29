

import 'package:caretaker/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/const/app_urls.dart';
import '../controllers/move_in_out_controller.dart';
import '../model/move_in_out.dart';


class MoveInOutView extends StatefulWidget {
  const MoveInOutView({Key? key}) : super(key: key);

  @override
  State<MoveInOutView> createState() => _MoveInOutViewState();
}

class _MoveInOutViewState extends State<MoveInOutView> {
  //visitInfoController visit_info_controller = Get.put(visitInfoController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tabBarItem = TabBar(
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0xFFc4c4c4),
      tabs: [
        Tab(
          child: Text(
            'Move In',
            style: TextStyle(fontSize: 15,color: Colors.white),
          ),
        ),
        Tab(
          child: Text(
            'Move Out',
            style: TextStyle(fontSize: 15,color: Colors.white),
          ),
        ),

      ],
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:
        AppBar(
          shape: Border(
            bottom: BorderSide(color: const Color(0xFFc4c4c4), width: 1),
          ),
          backgroundColor: Colors.transparent,
          // Set the background color to transparent
          leading: IconButton(
            padding: EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
            iconSize: 15,
          ),
          titleSpacing: 0,
          elevation: 0,
          title: Text(
            'Move In/Out',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          bottom: tabBarItem,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomTheme.appTheme, CustomTheme.appTheme1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Only shows Move In ',
                    style: TextStyle(
                        fontSize: 14, color: const Color(0xFFc4c4c4)),
                  ),
                  SizedBox(height: 10),
                  GetBuilder<MoveInOutController>(
                    init: MoveInOutController(),
                    builder: (controller) {
                      return controller.moveInOutModel?.data != null && controller.moveInOutModel?.data?.checkIns?.length != 0
                          ? Expanded(
                              child: ProfileContainer(
                                  moveIndataList: controller.moveInOutModel?.data?.checkIns,
                                  moveOutDataList: [],
                                  type: '1',)
                      )
                          : loder();
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Only shows Move Out data',
                    style: TextStyle(
                        fontSize: 14, color: const Color(0xFFc4c4c4)),
                  ),
                  SizedBox(height: 10),
                  GetBuilder<MoveInOutController>(
                    init: MoveInOutController(),
                    builder: (controller) {
                      return controller.moveInOutModel?.data != null && controller.moveInOutModel?.data?.checkOuts?.length != 0
                          ? Expanded(
                          child: ProfileContainer(
                            moveIndataList: [],
                            moveOutDataList: controller.moveInOutModel?.data?.checkOuts,
                            type: '2',)
                      )
                          : loder();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
   Widget loder()
   {
     return Center(
       child: Container(
         child: Column(children: [
           Lottie.network(
               'https://assets-v2.lottiefiles.com/a/ebf552bc-1177-11ee-8524-57b09b2cd38d/PaP7jkQFk9.json')
         ]),
       )); }
}

class ProfileContainer extends StatefulWidget {
  List<CheckIns>? moveIndataList;
  List<CheckOuts>? moveOutDataList;
  String type;
  ProfileContainer(
      {required this.moveIndataList, required this.moveOutDataList, required this.type});

  @override
  State<ProfileContainer> createState() => ProfileContainerState();

}
class ProfileContainerState extends State<ProfileContainer> {
 // CheckIns? inData ;
  //CheckOuts? outData;
  MoveInOutController moveInOutController = Get.put(MoveInOutController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.4,
      width: Get.width,
      child: widget.type =='1' ? ListView.builder(
        itemCount: widget.moveIndataList?.length,
        itemBuilder: (context, index) {
          var inData = widget.moveIndataList![index];
          return GestureDetector(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(
                  vertical: 10,horizontal: 10
              ),
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: CustomTheme.grey,
                    blurStyle:BlurStyle.outer ,
                    //spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(text: 'Id : ${inData?.id}'),
                      customText(text: '  Flat : ${inData?.unit} '),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Name : ${inData?.name} '),
                      customText(text: 'Phone : ${inData?.phone} '),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Email: ${inData?.email}'),
                      customText(text: 'Rent  : ${inData?.rent}'),
                    //  customText(text: 'OnBoarding  :  ${inData?.onboarding}'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                    ],
                  ),
                /*  const SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'From  :  ${dateConvert('${inData?.from}')}'),
                      customText(text: 'To  :  ${dateConvert('${inData?.from}')}'),
                    ],
                  ),*/
                  const SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Pending :  ${inData?.pending}'),
                      customText(text: 'Deposit : ${inData?.deposit}'),

                     // customText(text: 'Move Out  :  ${dateConvert('${inData?.moveOut}')}'),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      customText(text: 'Move In  :  ${dateConvert('${inData?.moveIn}')}',textSize: 15),
                      inData.checkedIn == 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                          onPressed: ()async {

                            moveInOutController.showMoveInAlertDialog(context,inData.id,"Move In");
                          }, child: Text("Move IN",style: TextStyle(color: Colors.white),)):Container()
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ):ListView.builder(
        itemCount: widget.moveOutDataList?.length,
        itemBuilder: (context, index) {
        var  outData = widget.moveOutDataList![index];
          return GestureDetector(
            onTap: () {

            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(
                  vertical: 10,horizontal: 10
              ),
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: CustomTheme.grey,
                    blurStyle:BlurStyle.outer ,
                    //spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Id : ${outData?.id} '),
                      customText(text: 'Flat : ${outData?.unit} '),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Name : ${outData?.name} '),
                      customText(text: 'Phone : ${outData?.phone} '),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Email: ${outData?.email}'),
                      customText(text: 'Rent  : ${outData?.rent}'),


                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  customText(text: 'OnBoarding  :  ${outData?.onboarding}'),

                    ],
                  ),
               /*   const SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'From  :  ${dateConvert('${outData?.from}')}'),
                      customText(text: 'To  :  ${dateConvert('${outData?.from}')}'),
                    ],
                  ),*/
                  const SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     // customText(text: 'Move In  :  ${dateConvert('${outData?.moveIn}')}'),
                      customText(text: 'Pending  :  ${dateConvert('${outData?.pending}')}'),
                      customText(text: 'Deposit :${outData?.deposit}'),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: 'Move Out  :  ${dateConvert('${outData?.moveOut}')}',textSize: 15,),
                      outData?.checkedOut == 0 ? ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600),
                          onPressed: (){

                            moveInOutController.showMoveInAlertDialog(context,outData.id,"Move Out");
                          },
                          child: const Text("Move Out",style: TextStyle(color: Colors.white),)):Container()
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

   Widget customText({required String text,double textSize = 13,Color color = Colors.black}){
    return Container(
      alignment: Alignment.centerLeft,
      width: Get.width*0.44,
      height: Get.width*0.04,
      child: FittedBox(
        child: Text(text,
          maxLines: 2,
          style: TextStyle(
              fontSize: textSize, fontWeight: FontWeight.w500,
          color: color),
        ),
      ),
    );
  }
}

