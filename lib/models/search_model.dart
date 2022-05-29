// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(dynamic str) => SearchModel.fromJson(json.decode(str));

// dynamic searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory SearchModel.fromJson(Map<dynamic, dynamic> json) => SearchModel(
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
    this.checked,
    this.dataNew,
  });

  List<Checked>? checked;
  List<Checked>? dataNew;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    checked: List<Checked>.from(json["checked"].map((x) => Checked.fromJson(x))),
    dataNew: List<Checked>.from(json["new"].map((x) => Checked.fromJson(x))),
  );
  //
  // Map<dynamic, dynamic> toJson() => {
  //   "checked": List<dynamic>.from(checked.map((x) => x.toJson())),
  //   "new": List<dynamic>.from(dataNew.map((x) => x.toJson())),
  // };
}

class Checked {
  Checked({
    this.id,
    this.time,
    this.date,
    this.image,
    this.seen,
    this.name,
    this.visitId,
  });

  dynamic id;
  dynamic time;
  dynamic date;
  dynamic image;
  dynamic seen;
  dynamic name;
  dynamic visitId;

  factory Checked.fromJson(Map<dynamic, dynamic> json) => Checked(
    id: json["id"],
    time: json["time"],
    date: json["date"],
    image: json["image"],
    seen: json["seen"],
    name: json["name"],
    visitId: json["visit_id"],
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "id": id,
  //   "time": time,
  //   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  //   "image": image,
  //   "seen": seen,
  //   "name": name,
  // };
}
