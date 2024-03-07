class Createticket {
  String? id;
  String? propId;
  String? unitId;
  String? category;
  String? description;
  String? status;
  List<Proofs>? proofs;

  Createticket(
      {this.id,
        this.propId,
        this.unitId,
        this.category,
        this.description,
        this.status,
        this.proofs});

  Createticket.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    propId = json['propId'];
    unitId = json['unitId'];
    category = json['category'];
    description = json['description'];
    status = json['status'];
    if (json['proofs'] != null) {
      proofs = <Proofs>[];
      json['proofs'].forEach((v) {
        proofs!.add(new Proofs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['propId'] = this.propId;
    data['unitId'] = this.unitId;
    data['category'] = this.category;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.proofs != null) {
      data['proofs'] = this.proofs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Proofs {
  String? url;

  Proofs({this.url});

  Proofs.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}