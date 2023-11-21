import 'asset_model.dart';
import 'property_model.dart';

class HouseModel {
  String id;
  String propertyId;
  String houseId;
  String gdprAgreement;
  String rooms;
  String photos;
  String rent;
  String advance;
  String facilities;
  String address;
  String location;
  String status;
  String tenantId;
  String assetId;
  String createdOn;
  List<AssetsModel> assetList;
  PropertyModel mPropertyModel;

  HouseModel(
      {required this.id,
      required this.propertyId,
      required this.houseId,
      required this.gdprAgreement,
      required this.rooms,
      required this.photos,
      required this.rent,
      required this.advance,
      required this.facilities,
      required this.address,
      required this.location,
      required this.status,
      required this.tenantId,
      required this.assetId,
      required this.assetList,
      required this.mPropertyModel,
      required this.createdOn});

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
        id: json['id'].toString(),
        propertyId: json['propertyId'],
        houseId: json['houseId'],
        gdprAgreement: json['gdprAgreement'],
        rooms: json['rooms'],
        photos: json['photos'],
        rent: json['rent'],
        advance: json['advance'],
        address: json['address'],
        facilities: json['facilities'],
        location: json['location'],
        status: json['status'],
        tenantId: json['tenantId'],
        assetId: json['assetId'],
        assetList: [],
        // assetList: (json["assetDet"] as List)
        //     .map((stock) => AssetsModel.fromJson(stock))
        //     .toList(),
        mPropertyModel: PropertyModel.fromJson(json['propertyDet']),
        createdOn: json['createdOn']);
  }
}
