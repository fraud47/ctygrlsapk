// To parse this JSON data, do

//     final videos = videosFromJson(jsonString);

import 'dart:convert';

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

String videosToJson(Videos data) => json.encode(data.toJson());

class Videos {
  Videos({
    this.id,
    this.title,
    this.url,
    this.desc,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String title;
  String url;
  String desc;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["_id"],
        title: json["title"],
        url: json["url"],
        desc: json["desc"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "url": url,
        "desc": desc,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
