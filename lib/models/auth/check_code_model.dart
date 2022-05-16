// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

VerificationModel verificationModelFromJson(dynamic str) => VerificationModel.fromJson(json.decode(str));

dynamic verificationModelToJson(VerificationModel data) => json.encode(data.toJson());

class VerificationModel {
  VerificationModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Code? data;

  factory VerificationModel.fromJson(Map<dynamic, dynamic> json) => VerificationModel(
    status: json["status"],
    message: json["message"],
    data: Code.fromJson(json["data"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Code {
  Code({
    this.id,
    this.idNumber,
    this.name,
    this.phone,
    this.nationality,
    this.birthrate,
    this.age,
    this.gender,
    this.email,
    this.deviceToken,
    this.idImage,
    this.token,
  });

  dynamic id;
  dynamic idNumber;
  dynamic name;
  dynamic phone;
  dynamic nationality;
  dynamic birthrate;
  dynamic age;
  dynamic gender;
  dynamic email;
  dynamic deviceToken;
  dynamic idImage;
  dynamic token;

  factory Code.fromJson(Map<dynamic, dynamic> json) => Code(
    id: json["id"],
    idNumber: json["id_number"],
    name: json["name"],
    phone: json["phone"],
    nationality: json["nationality"],
    birthrate: json["birthrate"],
    age: json["age"],
    gender: json["gender"],
    email: json["email"],
    deviceToken: json["device_token"],
    idImage: json["ID_image"],
    token: json["token"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "id_number": idNumber,
    "name": name,
    "phone": phone,
    "nationality": nationality,
    "birthrate": birthrate,
    "age": age,
    "gender": gender,
    "email": email,
    "device_token": deviceToken,
    "ID_image": idImage,
    "token": token,
  };
}
