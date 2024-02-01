class CareTakerLoginModelNew {
  int? userId;
  String? name;
  String? phone;
  String? role;
  String? image;
  String? email;
  String? token;
  int? callSync;
  List<dynamic>? propertyId;

  CareTakerLoginModelNew(
      {this.userId,
        this.name,
        this.phone,
        this.role,
        this.image,
        this.email,
        this.token,
        this.callSync,
        this.propertyId});

  CareTakerLoginModelNew.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    image = json['image'];
    email = json['email'];
    token = json['token'];
    callSync = json['callSync'];
    if (json['propertyId'] != null) {
      propertyId = <dynamic>[];
      json['propertyId'].forEach((v) {
        propertyId!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['image'] = this.image;
    data['email'] = this.email;
    data['token'] = this.token;
    data['callSync'] = this.callSync;
    if (this.propertyId != null) {
      data['propertyId'] = this.propertyId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}