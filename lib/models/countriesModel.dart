// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'dart:convert';

CountriesModel countriesModelFromJson(dynamic str) => CountriesModel.fromJson(json.decode(str));

class CountriesModel {
  CountriesModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<CountriesModelData>? data;

  factory CountriesModel.fromJson(Map<dynamic, dynamic> json) => CountriesModel(
    status: json["status"],
    message: json["message"],
    data: List<CountriesModelData>.from(json["data"].map((x) => CountriesModelData.fromJson(x))),
  );
}

class CountriesModelData {
  CountriesModelData({
    this.id,
    this.name,
  });

  dynamic id;
  dynamic name;

  factory CountriesModelData.fromJson(Map<dynamic, dynamic> json) => CountriesModelData(
    id: json["id"],
    name: json["name"],
  );
}
