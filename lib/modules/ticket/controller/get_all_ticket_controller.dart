import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:caretaker/modules/ticket/view/create_ticket.dart';
import 'package:caretaker/utils/view/rie_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../utils/const/app_urls.dart';
import '../../../utils/services/rie_user_api_service.dart';
import '../model/CreateTicket.dart';
import '../model/TicketListModel.dart';
import '../model/ticketModel.dart';
import '../model/ticket_config_model.dart';

class AllTicketController extends GetxController{
  TextEditingController ticketDescription = TextEditingController();
  bool isLoading = false;
  //String? selectFlat = 'Select Flat';
  File ticketImage = File('');
  RxList<String> ticketImgUrl = <String>[].obs;
  final ImagePicker _picker = ImagePicker();
  final RIEUserApiService _apiService = RIEUserApiService();
  TicketListModel getAllDetails = TicketListModel();
  TicketConfigModel ticketConfigModel = TicketConfigModel();
  TicketModel getSingleTicketDetails = TicketModel();
  List<String>? ticketCategoriesList;
  List<String>? ticketStatusList;
  List<Properties>? ticketPropertiesList;
  List<Flats>? flatsList;
  Properties? selectedProperty ;
  Flats? selectedFlats;
  String? selectedCategory ;
  String? selectedStatus ;

 /* Properties? selectedProperty = Properties(title: 'Select Flat',value: 0);
  String? selectedCategory ='Select Category';
  String? selectedStatus ='Select Status';*/

  @override
  void onInit() {
    super.onInit();
    getData();
    //fetchTicketListDetails();
  }

  void getData()async{
    await  fetchTicketListDetails();
   // await fetchTicketConfigListDetails();
  }
  Future<void> fetchTicketListDetails() async {
    String url = AppUrls.tickets;
    isLoading = true;
    final response = await _apiService.getApiCallWithURL(endPoint: url);

    final data = response as Map<String, dynamic>;
    if (data['message'].toString().toLowerCase().contains('success')) {
      getAllDetails = TicketListModel.fromJson(data);
      update();
      isLoading=false;
    } else {
      getAllDetails= TicketListModel(
        message: 'failure',
      );
      isLoading=false;
      update();
    }
  }

  Future<void> fetchTicketConfigListDetails() async {
    String url = AppUrls.ticketsConfig;
    isLoading = true;
    final response = await _apiService.getApiCallWithURL(endPoint: url);

    final data = response as Map<String, dynamic>;
    if (data['message'].toString().toLowerCase().contains('success')) {
      ticketConfigModel = TicketConfigModel.fromJson(data);
      //ticketCategoriesList?.add('Select Category');
    //  log('aaaaaaaaaaaaa'+ '${ticketCategoriesList?[0]}');
     // var cat = ticketConfigModel.data?.categories??[];
       ticketCategoriesList = ticketConfigModel.data?.categories??[];
     // ticketCategoriesList?.addAll(cat);
      ticketCategoriesList?.forEach((element) {log(element); });
      update();
      isLoading=false;

     // ticketStatusList?.add('Select Status');
    //  var stat = ticketConfigModel.data?.status??[];
     // ticketStatusList?.addAll(stat);
      ticketStatusList = ticketConfigModel.data?.status??[];
    //  ticketStatusList?.forEach((element) {log('skkkkk  $element'); });

    //  var prop = ticketConfigModel.data?.properties??[];
     ticketPropertiesList = ticketConfigModel.data?.properties??[];
     //flatsList = ticketConfigModel.data?.properties??[];
      //ticketPropertiesList?.add(Properties(title: 'Select Flat',value: 0));
     // ticketPropertiesList?.addAll(prop);
     // ticketPropertiesList?.forEach((element) {log('${element.value} ${element.title},'); });
      update();

    } else {
      ticketConfigModel = TicketConfigModel(
        message: 'failure',
      );
      isLoading=false;
      update();
    }
  }

  Future<int> createTicket({
    required String propertyId,
    String flatId ='',
    required String ticketCate,
    required String ticketDesc,
    required String ticketStat,

  }) async {
    String url = AppUrls.ticket;
    List<Map<String,String>> imgList = [];
    ticketImgUrl.forEach((element) { 
      imgList.add({'url':element});
    });
    Createticket c = Createticket.fromJson({
      "propId":propertyId.toString(),
      "unitId": flatId.toString(),
      "category": ticketCate,
      "description": ticketDesc,
      "status": ticketStat,
      "proofs": imgList
    });
    final response =
     await _apiService.postApiCallFormData(endPoint: url,
         bodyParams:c.toJson(),);
    /*await _apiService.postApiCall(endPoint: url,
      bodyParams: c.toJson()
      {
      "propId":propertyId.toString(),
      "unitId": flatId.toString(),
      "category": ticketCate,
      "description": ticketDesc,
      "status": ticketStat,
      "proofs": imgList
    },
    );*/
    
    final data = response as Map<String, dynamic>;

    return data['message'].toString().toLowerCase().contains('failure') ? 404 : 200;
  }

  Future<int> updateTicket({
    //location="+location+"&prop_type="+prop_type+"&added_on="+added_on+"&assign_to="+assign_to+"&contact_details="+contact_details+"&lead_status=Active"+"&origin="+area;
    required String flatId,
    required String ticketCate,
    required String ticketDesc,
    required String ticketStat,
    required String ticketId,
    required String propId,
  }) async {
    String url = AppUrls.ticket;
    List<Map<String,String>> imgList = [];
    for (var element in ticketImgUrl) {
      imgList.add({'url':element});
    }
    Createticket c = Createticket.fromJson({
      "id":ticketId,
      "unitId": flatId,
      "propId": propId,
      "category": ticketCate,
      "description": ticketDesc,
      "status": ticketStat,
      "proofs": imgList
    });
    final response = await _apiService.putApiCallFormData(endPoint: url, bodyParams: c.toJson(),
        /*{
      "id":ticketId,
      "unitId": flatId,
      "propId": propId,
      "category": ticketCate,
      "description": ticketDesc,
      "status": ticketStat,
      "proofs":
    }*/);
    final data = response as Map<String, dynamic>;

    return data['message'].toString().toLowerCase().contains('success') ? 200 : 404;
  }
  Future<void> fetchTicketDetails(String ticketId) async {
    String url = AppUrls.ticket;
    url = '$url?id=$ticketId';
    isLoading = true;
    final response = await _apiService.getApiCallWithURL(endPoint: url,);
    final data = response as Map<String, dynamic>;
    if (data['message'].toString().toLowerCase().contains('success')) {
      getSingleTicketDetails = TicketModel.fromJson(data);
      update();
      isLoading=false;
    } else {
      getSingleTicketDetails = TicketModel(
        message: 'failure',
      );
      isLoading=false;
      update();
    }
  }
Future<void> getTicketImgUrl(File imgaeFile)async {
 String url = AppUrls.ticketProof;
  final response = await _apiService.postApiCallWithImg(endPoint: url, bodyParams: {
   /* "id":ticketId,
    "unitId": flatId,
    "propId": propId,
    "category": ticketCate,
    "description": ticketDesc,
    "status": ticketStat,*/
  },img: imgaeFile,
   imgKey: 'file');
  final data = response as Map<String, dynamic>;
if(data['message']=='Image uploaded successfully')
  {
String url = '${data['url']}';
if(url.isNotEmpty){
  ticketImgUrl.add(url);
  ticketImage = File('');

}
    log('log Url ${data['url']}');
update();
   // return '${data['url']}';
  }
else{
  RIEWidgets.getToast(message: '${data['message']}', color: Colors.white);
 update();
  //return '';
}
}

  Future<void> updateTicketImg(BuildContext context) async {
    try {
      ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) => Container(
          color: const Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.green,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.photo_album,
                    color: Colors.blue,
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        ),
      );

      if (source != null) {

        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile == null) {

          // throw Exception('No image file was picked.');
        }
        else {
          File? croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile!.path,
           /* aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],*/
            androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),

          );

          if (croppedFile == null) {
            // throw Exception('Image cropping failed or was cancelled.');
          }
          isLoading = true;
          try {
            //String? downloadUrl = await _uploadFile(croppedFile!, type);
            ticketImage = croppedFile!;
            await getTicketImgUrl(ticketImage).toString();

            // individualProfileController.coverPhotoURL.value = downloadUrl!;
            isLoading = false;
            update();
          } catch (e) {
            isLoading = false;
            update();
          }
        }
      }
    } on PlatformException {
      // Handle exceptions related to camera, files and permissions

        isLoading = false;
        update();
    } catch (e) {

        isLoading = false;
        update();
    }
    update();
  }

}