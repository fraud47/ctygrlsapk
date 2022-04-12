// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

Document documentFromJson(String str) => Document.fromJson(json.decode(str));

String documentToJson(Document data) => json.encode(data.toJson());

class Document {
  Document({
    this.id,
    this.title,
    this.url,
    this.desc,
    this.createdAt,
  });

  String id;
  String title;
  String url;
  String desc;
  DateTime createdAt;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        desc: json["desc"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "desc": desc,
        "createdAt": createdAt.toIso8601String(),
      };
}
