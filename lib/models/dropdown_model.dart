// To parse this JSON data, do
//
//     final dropDownModel = dropDownModelFromJson(jsonString);

import 'dart:convert';

List<DropDownModel> dropDownModelFromJson(String str) => List<DropDownModel>.from(json.decode(str).map((x) => DropDownModel.fromJson(x)));

String dropDownModelToJson(List<DropDownModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropDownModel {
    int? userId;
    int? id;
    String? title;
    String? body;

    DropDownModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory DropDownModel.fromJson(Map<String, dynamic> json) => DropDownModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
 