// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}
