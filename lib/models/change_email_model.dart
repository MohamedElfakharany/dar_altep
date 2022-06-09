import 'dart:convert';

ConfirmPasswordModel confirmPasswordModelFromJson(dynamic str) => ConfirmPasswordModel.fromJson(json.decode(str));

class ConfirmPasswordModel {
  ConfirmPasswordModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory ConfirmPasswordModel.fromJson(Map<dynamic, dynamic> json) => ConfirmPasswordModel(
    status: json["status"],
    message: json["message"],
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////

SendNewEmailModel sendNewEmailModelFromJson(dynamic str) => SendNewEmailModel.fromJson(json.decode(str));

class SendNewEmailModel {
  SendNewEmailModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory SendNewEmailModel.fromJson(Map<dynamic, dynamic> json) => SendNewEmailModel(
    status: json["status"],
    message: json["message"],
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////

ResetEmailModel resetEmailModelFromJson(dynamic str) => ResetEmailModel.fromJson(json.decode(str));

class ResetEmailModel {
  ResetEmailModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory ResetEmailModel.fromJson(Map<dynamic, dynamic> json) => ResetEmailModel(
    status: json["status"],
    message: json["message"],
  );
}