import 'dart:convert';
import 'dart:developer';
import 'package:caretaker/models/property_model_new.dart';
import 'package:caretaker/modules/home/model/ticketModel.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:caretaker/models/care_taker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_urls.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<dynamic> careTLogin(String phone, String password) async {
  final response = await http.post(Uri.parse(AppUrls.careTakerLogin),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "phone": phone,
        "password": password,
      })
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    log('login data ${body}');
    return body;
  } else {
    throw Exception('Failed to load CareTaker User');
  }
}

Future<List<CareTakerModel>> allIssuesGet(String userId) async {
  final response = await http.get(
    Uri.parse('${AppUrls.careTaker}?userId=$userId'),
    headers: <String, String>{},
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    bool success = body["success"];
    if (success) {
      try {
        return (body["data"] as List)
            .map((stock) => CareTakerModel.fromJson(stock))
            .toList();
      } catch (e) {
        return [];
      }
    } else {
      throw Exception(body["message"]);
    }
  } else {
    throw Exception('Failed to Faq');
  }
}

Future<PropertyModelNew?> allPropertyGet(String propertyId) async {
  final response = await http.get(
    Uri.parse('${AppUrls.properties}?id=$propertyId'),
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    bool success = body["success"];
    if (success) {
      try {
        return PropertyModelNew.fromJson(body["data"]);
      } catch (e) {
        return null;
      }
    } else {
      throw Exception(body["message"]);
    }
  } else {
    throw Exception('Failed to House');
  }
}

Future<TicketModel?> allTicketGet() async {
  final response = await http.get(
    Uri.parse(AppUrls.tickets),
    headers: <String, String>{
      'admin-auth-token': GetStorage().read(Constants.token),
    },
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    debugPrint('response');
    debugPrint(body.toString());
    if (body["message"] == 'Success') {
      try {
        return TicketModel.fromJson(body['data']);
      } catch (e) {
        return null;
      }
    } else {
      throw Exception(body["message"]);
    }
  } else {
    throw Exception('Failed to Tickets');
  }
}

Future<dynamic> ticketUpdateApi(
  String id,
  String description,
  String image,
) async {
  final response = await http.put(Uri.parse(AppUrls.ticket),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "resolved": 'Closed',
        "resolveDescription": description,
        "resolveImg": image,
      }));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return body;
  } else {
    throw Exception('Failed to load Ticket');
  }
}

// Future<List<CTTicketModel>> allOTTicketGet(String id) async {
//   final response = await http.get(
//     Uri.parse('${AppConfig.otTicket}?ctStaffId=$id'),
//     headers: <String, String>{},
//   );
//   if (response.statusCode == 200) {
//     var body = jsonDecode(response.body);
//     int success = body["success"];
//     if (success == 1) {
//       try {
//         return (body["data"] as List)
//             .map((stock) => CTTicketModel.fromJson(stock))
//             .toList();
//       } catch (e) {
//         return [];
//       }
//     } else {
//       throw Exception(body["message"]);
//     }
//   } else {
//     throw Exception('Failed to House');
//   }
// }

// Future<dynamic> otTicketUpdateApi(
//   String id,
//   String description,
//   String image,
// ) async {
//   final response = await http.put(Uri.parse(AppConfig.otTicket),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         "id": id,
//         "resolved": 'Closed',
//         "resolveDescription": description,
//         "resolveImg": image,
//       }));
//   if (response.statusCode == 200) {
//     var body = jsonDecode(response.body);
//     return body;
//   } else {
//     throw Exception('Failed to load Ticket');
//   }
// }

Future<String> uploadImage(String path, String name) async {
  var request =
      http.MultipartRequest("POST", Uri.parse(AppUrls.urlImgUpload));
  var pic = await http.MultipartFile.fromPath("image", path);
  request.files.add(pic);
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  debugPrint(responseString.toString());
  return name;
}
