// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

class ChangePasswordModel {
  ChangePasswordModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    status: json["status"],
    message: json["message"],
  );
}

SendEmailModel sendEmailModelFromJson(dynamic str) => SendEmailModel.fromJson(json.decode(str));

class SendEmailModel {
  SendEmailModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory SendEmailModel.fromJson(Map<dynamic, dynamic> json) => SendEmailModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.code,
  });

  dynamic code;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    code: json["code"],
  );
}

// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);


ResetPasswordModel resetPasswordModelFromJson(dynamic str) => ResetPasswordModel.fromJson(json.decode(str));

class ResetPasswordModel {
  ResetPasswordModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory ResetPasswordModel.fromJson(Map<dynamic, dynamic> json) => ResetPasswordModel(
    status: json["status"],
    message: json["message"],
  );
}

