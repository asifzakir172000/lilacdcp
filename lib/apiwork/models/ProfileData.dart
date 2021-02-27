// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

// List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

// String profileModelToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  ProfileModel({
    this.name,
    this.id,
    this.email,
    this.password,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Name name;
  String id;
  String email;
  String password;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: Name.fromJson(json["name"]),
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    userType: json["user_type"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "_id": id,
    "email": email,
    "password": password,
    "user_type": userType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Name {
  Name({
    this.firstName,
    this.lastName,
  });

  String firstName;
  String lastName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}
