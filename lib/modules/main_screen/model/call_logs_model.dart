class CallLogsModel {
  Data? data;
  String? message;

  CallLogsModel({this.data, this.message});

  CallLogsModel.fromJson(Map<String, dynamic> json) {
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
  String? staffPhone;
  String? leadPhone;
  String? callType;
  int? duration;
  String? date;
  String? addedOn;

  Data(
      {this.id,
        this.staffPhone,
        this.leadPhone,
        this.callType,
        this.duration,
        this.date,
        this.addedOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffPhone = json['staffPhone'];
    leadPhone = json['leadPhone'];
    callType = json['callType'];
    duration = json['duration'];
    date = json['date'];
    addedOn = json['addedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staffPhone'] = this.staffPhone;
    data['leadPhone'] = this.leadPhone;
    data['callType'] = this.callType;
    data['duration'] = this.duration;
    data['date'] = this.date;
    data['addedOn'] = this.addedOn;
    return data;
  }
}