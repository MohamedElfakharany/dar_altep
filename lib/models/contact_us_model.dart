// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(dynamic str) => ContactUsModel.fromJson(json.decode(str));

// dynamic contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory ContactUsModel.fromJson(Map<dynamic, dynamic> json) => ContactUsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "status": status,
  //   "message": message,
  //   "data": data.toJson(),
  // };
}

class Data {
  Data({
    this.id,
    this.type,
    this.email,
    this.phone,
    this.message,
  });

  dynamic id;
  dynamic type;
  dynamic email;
  dynamic phone;
  dynamic message;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    id: json["id"],
    type: json["type"],
    email: json["email"],
    phone: json["phone"],
    message: json["message"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "type": type,
    "email": email,
    "phone": phone,
    "message": message,
  };
}
