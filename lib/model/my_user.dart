// To parse this JSON data, do
//
//     final myUserModel = myUserModelFromJson(jsonString);

import 'dart:convert';

////////////////////////////////////////
///
/// SINGLE USER METHODES
///
MyUserModel myUserModelFromJson(String str) =>
    MyUserModel.fromJson(json.decode(str));

String myUserModelToJson(MyUserModel data) => json.encode(data.toJson());

/////////////////////////////////////////////
///
/// USER LIST METHODES
///
List<MyUserModel> myUserModeListFromJson(String str) => List<MyUserModel>.from(
    json.decode(str).map((x) => MyUserModel.fromJson(x)));

String myUserModelListToJson(List<MyUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyUserModel {
  final int id;
  final String uniqueId;
  final String name;
  final String firstname;
  final String email;
  final String phone;
  final dynamic pass;
  final dynamic emailVerifiedAt;
  String status;
  final dynamic qrcode;
  int isChecked;

  MyUserModel({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.firstname,
    required this.email,
    required this.phone,
    required this.pass,
    required this.emailVerifiedAt,
    required this.status,
    required this.qrcode,
    required this.isChecked,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> json) => MyUserModel(
        id: json["id"],
        uniqueId: json["unique_id"],
        name: json["name"],
        firstname: json["firstname"],
        email: json["email"],
        phone: json["phone"],
        pass: json["pass"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        qrcode: json["qrcode"],
        isChecked: json["is_checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "name": name,
        "firstname": firstname,
        "email": email,
        "phone": phone,
        "pass": pass,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "qrcode": qrcode,
        "is_checked": isChecked,
      };

  static List<MyUserModel> userList = [];
}
