class TicketModel {
  Data? data;
  String? message;

  TicketModel({this.data, this.message});

  TicketModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  dynamic tenantId;
  int? unitId;
  int? propId;
  String? category;
  String? description;
  String? status;
  dynamic remindOn;
  String? createdOn;
  String? updatedOn;
  dynamic closedOn;
  int? createdBy;
  List<FollowUps>? followUps;


  Data(
      {this.id,
        this.tenantId,
        this.unitId,
        this.propId,
        this.category,
        this.description,
        this.status,
        this.remindOn,
        this.createdOn,
        this.updatedOn,
        this.closedOn,
        this.createdBy,
        this.followUps});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    unitId = json['unitId'];
    propId = json['propId'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    remindOn = json['remindOn'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    closedOn = json['closedOn'];
    createdBy = json['createdBy'];
    if (json['followUps'] != null) {
      followUps = <FollowUps>[];
      json['followUps'].forEach((v) {
        followUps!.add(new FollowUps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenantId'] = this.tenantId;
    data['unitId'] = this.unitId;
    data['propId'] = this.propId;
    data['category'] = this.category;
    data['description'] = this.description;
    data['status'] = this.status;
    data['remindOn'] = this.remindOn;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['closedOn'] = this.closedOn;
    data['createdBy'] = this.createdBy;
    if (this.followUps != null) {
      data['followUps'] = this.followUps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowUps {
  String? followUp;
  String? addedBy;
  String? addedOn;

  FollowUps({this.followUp, this.addedBy, this.addedOn});

  FollowUps.fromJson(Map<String, dynamic> json) {
    followUp = json['followUp'];
    addedBy = json['addedBy'];
    addedOn = json['addedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followUp'] = this.followUp;
    data['addedBy'] = this.addedBy;
    data['addedOn'] = this.addedOn;
    return data;
  }
}