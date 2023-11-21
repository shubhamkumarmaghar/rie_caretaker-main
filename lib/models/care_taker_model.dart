class CareTakerModel {
  String id;
  String ownerId;
  List<int> propertyId;
  String name;
  String email;
  String phone;
  String alternativeMobile;
  String idProof;
  String eduDoc;
  String address;
  String photo;
  String panCard;
  String aadharCard;
  String password;
  String role;
  String pfAccount;
  String bankDetails;
  String empId;
  String token;
  String createdOn;

  CareTakerModel(
      {required this.id,
      required this.ownerId,
      required this.propertyId,
      required this.name,
      required this.email,
      required this.phone,
      required this.alternativeMobile,
      required this.idProof,
      required this.eduDoc,
      required this.address,
      required this.photo,
      required this.panCard,
      required this.aadharCard,
      required this.password,
      required this.role,
      required this.pfAccount,
      required this.bankDetails,
      required this.empId,
      required this.token,
      required this.createdOn});

  factory CareTakerModel.fromJson(Map<String, dynamic> json) {
    var propertyDynamic = json['propertyId'];
    List<int> proList = [];
    if (propertyDynamic.toString().contains("[")) {
      List<dynamic> propertyList = json['propertyId']
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',');
      for (var img in propertyList) {
        proList.add(int.parse(img));
      }
    } else {
      proList.add(propertyDynamic);
    }
    return CareTakerModel(
        id: json['userId'].toString(),
        ownerId: json['ownerId'] ?? 'NA',
        token: json['token'] ?? 'NA',
        propertyId: proList,
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        alternativeMobile: json['alternativeMobile'] ?? 'NA',
        idProof: json['idProof'] ?? 'NA',
        eduDoc: json['eduDoc'] ?? 'NA',
        address: json['address'] ?? 'NA',
        photo: 'NA',
        panCard: json['panCard'] ?? 'NA',
        aadharCard: json['aadharCard'] ?? 'NA',
        password: json['password'] ?? 'NA',
        role: json['role'] ?? 'NA',
        pfAccount: json['pfAccount'] ?? 'NA',
        bankDetails: json['bankDetails'] ?? 'NA',
        empId: json['empId'] ?? 'NA',
        createdOn: json['createdOn'] ?? 'NA');
  }
}
