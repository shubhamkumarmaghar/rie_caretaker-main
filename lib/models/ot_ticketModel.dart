import 'dart:convert';

class CTTicketModel {
  String id;
  String ctStaffId;
  String ticket;
  String openDate;
  String closeDate;
  String resolved;
  String comments;
  String houseId;
  String propertyId;
  String resolveDescription;
  List<String> resolveImg;
  String createdOn;

  CTTicketModel(
      {required this.id,
      required this.ctStaffId,
      required this.ticket,
      required this.openDate,
      required this.closeDate,
      required this.resolved,
      required this.comments,
      required this.houseId,
      required this.propertyId,
      required this.resolveDescription,
      required this.resolveImg,
      required this.createdOn});

  factory CTTicketModel.fromJson(Map<String, dynamic> json) {
    var imageDynamic = json['resolveImg'];
    List<String> images = [];
    if (imageDynamic.toString().contains("[")) {
      var imageDynamicList = jsonDecode(json['resolveImg']);
      for (var img in imageDynamicList) {
        images.add(img.toString());
      }
    } else {
      images.add(imageDynamic);
    }
    return CTTicketModel(
        id: json['id'].toString(),
        ctStaffId: json['ctStaffId'],
        ticket: json['ticket'],
        openDate: json['openDate'] ?? 'NA',
        closeDate: json['closeDate'] ?? 'NA',
        resolved: json['resolved'],
        comments: json['comments'] ?? json['description'] ?? 'NS',
        houseId: json['houseId'] ?? 'NA',
        propertyId: json['propertyId'],
        resolveDescription: json['resolveDescription'],
        resolveImg: images,
        createdOn: json['createdOn']);
  }
}
