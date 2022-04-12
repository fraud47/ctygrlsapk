// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.fullname,
    this.surname,
    this.email,
    this.role,
    this.accessToken,
    this.service,
  });

  String id;
  String fullname;
  String surname;
  String email;
  String role;
  String accessToken;
  bool service;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        surname: json["surname"],
        email: json["email"],
        role: json["role"],
        accessToken: json["accessToken"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "surname": surname,
        "email": email,
        "role": role,
        "accessToken": accessToken,
        "service": service,
      };
}
