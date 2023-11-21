import 'dart:convert';

import 'package:caretaker/utils/const/app_urls.dart';

class PropertyModel {
  String id;
  String ownerId;
  String relationShip;
  String name;
  String type;
  String plots;
  String floor;
  String facility;
  String amenities;
  String address;
  String area;
  String city;
  String latlng;
  String photo;
  String video;
  String description;
  String price;
  String ownerPhone;
  String month;
  String bhkType;
  String year;
  String createdOn;
  bool isFav = false;
  List<String> images;
  List<String> amenitiesList;

  PropertyModel(
      {required this.id,
      required this.ownerId,
      required this.relationShip,
      required this.name,
      required this.type,
      required this.plots,
      required this.floor,
      required this.facility,
      required this.amenities,
      required this.address,
      required this.area,
      required this.city,
      required this.latlng,
      required this.photo,
      required this.video,
      required this.description,
      required this.price,
      required this.images,
      required this.month,
      required this.bhkType,
      required this.year,
      required this.amenitiesList,
      required this.ownerPhone,
      required this.createdOn});

  PropertyModel copyWith() => PropertyModel(
      id: id,
      ownerId: ownerId,
      relationShip: relationShip,
      name: name,
      type: type,
      plots: plots,
      floor: floor,
      facility: facility,
      amenities: amenities,
      address: address,
      area: area,
      city: city,
      bhkType: bhkType,
      latlng: latlng,
      photo: photo,
      video: video,
      description: description,
      price: price,
      month: month,
      year: year,
      ownerPhone: ownerPhone,
      images: [],
      amenitiesList: [],
      createdOn: createdOn);

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    var imageDynamic = json['photo'];
    List<String> images = [];
    if (imageDynamic.toString().contains("[")) {
      var imageDynamicList = jsonDecode(json['photo']);
      for (var img in imageDynamicList) {
        images.add(img.toString());
      }
    } else {
      images.add(imageDynamic);
    }
    var iconDynamic = json['amenities'];
    List<String> amenitiesTemp = [];
    if (iconDynamic.toString().contains("[")) {
      var listAmenties = jsonDecode(json['amenities']);
      for (var item in listAmenties) {
        amenitiesTemp.add(item);
      }
    }

    return PropertyModel(
        id: json['id'].toString(),
        ownerId: json['ownerId'],
        relationShip: json['relationShip'],
        name: json['name'],
        type: json['type'],
        plots: json['plots'],
        floor: json['floor'],
        facility: json['facility'],
        amenities: json['amenities'],
        address: json['address'],
        area: json['area'],
        city: json['city'],
        month: json['month'] ?? 'NA',
        year: json['year'] ?? 'NA',
        latlng: json['latlng'],
        photo: json['photo'],
        bhkType: json['bhkType'],
        video: json['video'],
        description: json['description'],
        price: json['price'].toString(),
        ownerPhone: AppUrls.phone,
        images: images,
        amenitiesList: amenitiesTemp,
        createdOn: json['createdOn']);
  }
}
