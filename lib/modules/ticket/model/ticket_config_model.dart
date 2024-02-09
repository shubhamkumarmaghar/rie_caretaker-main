/*
class TicketConfigModel {
  Data? data;
  String? message;

  TicketConfigModel({this.data, this.message});

  TicketConfigModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? categories;
  List<String>? status;
  List<Properties>? properties;


  Data({this.categories, this.status, this.properties});

  Data.fromJson(Map<String, dynamic> json) {
    categories = json['categories'].cast<String>();
    status = json['status'].cast<String>();
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories'] = this.categories;
    data['status'] = this.status;
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  String? title;
  int? value;

  Properties({this.title, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}*/

class TicketConfigModel {
  Data? data;
  String? message;

  TicketConfigModel({this.data, this.message});

  TicketConfigModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? categories;
  List<String>? status;
  List<Properties>? properties;

  Data({this.categories, this.status, this.properties});

  Data.fromJson(Map<String, dynamic> json) {
    categories = json['categories'].cast<String>();
    status = json['status'].cast<String>();
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories'] = this.categories;
    data['status'] = this.status;
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  String? title;
  int? value;
  List<Flats>? flats;

  Properties({this.title, this.value, this.flats});

  Properties.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    if (json['flats'] != null) {
      flats = <Flats>[];
      json['flats'].forEach((v) {
        flats!.add(Flats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['value'] = value;
    if (flats != null) {
      data['flats'] = flats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Flats {
  String? title;
  int? value;

  Flats({this.title, this.value});

  Flats.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}