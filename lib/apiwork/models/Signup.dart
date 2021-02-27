import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
  Signup({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  String data;

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
