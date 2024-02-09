class MoveInOutModel {
  Data? data;
  String? message;

  MoveInOutModel({this.data, this.message});

  MoveInOutModel.fromJson(Map<String, dynamic> json) {
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
  List<CheckIns>? checkIns;
  List<CheckOuts>? checkOuts;
  Data({this.checkIns, this.checkOuts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['checkIns'] != null) {
      checkIns = <CheckIns>[];
      json['checkIns'].forEach((v) {
        checkIns!.add(new CheckIns.fromJson(v));
      });
    }
    if (json['checkOuts'] != null) {
      checkOuts = <CheckOuts>[];
      json['checkOuts'].forEach((v) {
        checkOuts!.add(new CheckOuts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkIns != null) {
      data['checkIns'] = this.checkIns!.map((v) => v.toJson()).toList();
    }
    if (this.checkOuts != null) {
      data['checkOuts'] = this.checkOuts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckIns {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? from;
  String? till;
  String? moveIn;
  String? moveOut;
  int? rent;
  int? deposit;
  int? onboarding;
  String? unit;
  int? pending;
  int? checkedIn;

  CheckIns(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.from,
        this.till,
        this.moveIn,
        this.moveOut,
        this.rent,
        this.deposit,
        this.onboarding,
        this.unit,
        this.pending,
        this.checkedIn});

  CheckIns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    from = json['from'];
    till = json['till'];
    moveIn = json['moveIn'];
    moveOut = json['moveOut'];
    rent = json['rent'];
    deposit = json['deposit'];
    onboarding = json['onboarding'];
    unit = json['unit'];
    pending = json['pending'];
    checkedIn = json['checkedIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['from'] = this.from;
    data['till'] = this.till;
    data['moveIn'] = this.moveIn;
    data['moveOut'] = this.moveOut;
    data['rent'] = this.rent;
    data['deposit'] = this.deposit;
    data['onboarding'] = this.onboarding;
    data['unit'] = this.unit;
    data['pending'] = this.pending;
    data['checkedIn'] = this.checkedIn;
    return data;
  }
}

class CheckOuts {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? from;
  String? till;
  String? moveIn;
  String? moveOut;
  int? rent;
  int? deposit;
  int? onboarding;
  String? unit;
  int? pending;
  int? checkedOut;

  CheckOuts(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.from,
        this.till,
        this.moveIn,
        this.moveOut,
        this.rent,
        this.deposit,
        this.onboarding,
        this.unit,
        this.pending,
        this.checkedOut});

  CheckOuts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    from = json['from'];
    till = json['till'];
    moveIn = json['moveIn'];
    moveOut = json['moveOut'];
    rent = json['rent'];
    deposit = json['deposit'];
    onboarding = json['onboarding'];
    unit = json['unit'];
    pending = json['pending'];
    checkedOut = json['checkedOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['from'] = this.from;
    data['till'] = this.till;
    data['moveIn'] = this.moveIn;
    data['moveOut'] = this.moveOut;
    data['rent'] = this.rent;
    data['deposit'] = this.deposit;
    data['onboarding'] = this.onboarding;
    data['unit'] = this.unit;
    data['pending'] = this.pending;
    data['checkedOut'] = this.checkedOut;
    return data;
  }
}