// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(dynamic str) =>
    UserModel.fromJson(json.decode(str));

dynamic userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      status: json["status"],
      message: json["message"],
      data: json['data'] != null ? Data.fromJson(json['data']) : null);

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.nationality,
      this.birthrate,
      this.age,
      this.gender,
      this.verificationCode,
      this.token,
      this.idImage});

  dynamic name;
  dynamic email;
  dynamic password;
  dynamic phone;
  dynamic nationality;
  dynamic birthrate;
  dynamic age;
  dynamic gender;
  dynamic verificationCode;
  dynamic token;
  dynamic idImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        nationality: json["nationality"],
        birthrate: json["birthrate"],
        age: json["age"],
        gender: json["gender"],
        verificationCode: json["verification_code"],
        token: json["token"],
        idImage: json["ID_image"],
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "nationality": nationality,
        "birthrate": birthrate,
        "age": age,
        "gender": gender,
        "verification_code": verificationCode,
        "token": token,
        "ID_image": idImage,
      };
}
