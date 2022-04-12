// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    this.socialmedia,
    this.id,
    this.serviceName,
    this.description,
    this.location,
    this.websiteUrl,
    this.category,
    this.email,
    this.phoneNumber,
    this.available,
    this.published,
    this.userId,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<String> socialmedia;
  String id;
  String serviceName;
  String description;
  String location;
  String websiteUrl;
  String category;
  String email;
  String phoneNumber;
  bool available;
  bool published;
  String userId;
  String logoUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        socialmedia: List<String>.from(json["socialmedia"].map((x) => x)),
        id: json["_id"],
        serviceName: json["serviceName"],
        description: json["description"],
        location: json["location"],
        websiteUrl: json["websiteUrl"],
        category: json["category"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        available: json["available"],
        published: json["published"],
        userId: json["userId"],
        logoUrl: json["logoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "socialmedia": List<dynamic>.from(socialmedia.map((x) => x)),
        "_id": id,
        "serviceName": serviceName,
        "description": description,
        "location": location,
        "websiteUrl": websiteUrl,
        "category": category,
        "email": email,
        "phoneNumber": phoneNumber,
        "available": available,
        "published": published,
        "userId": userId,
        "logoUrl": logoUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
