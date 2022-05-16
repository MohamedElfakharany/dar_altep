// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsondynamic);

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
        data: Data.fromJson(json["data"]),
      );

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
      this.token});

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
      };
}