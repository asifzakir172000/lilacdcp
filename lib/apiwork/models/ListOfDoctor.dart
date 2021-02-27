// To parse this JSON data, do
//
//     final listOfDoctors = listOfDoctorsFromJson(jsonString);

// import 'dart:convert';
//
// List<ListOfDoctors> listOfDoctorsFromJson(String str) => List<ListOfDoctors>.from(json.decode(str).map((x) => ListOfDoctors.fromJson(x)));
//
// String listOfDoctorsToJson(List<ListOfDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOfDoctors {
  ListOfDoctors({
    this.name,
    this.id,
    this.email,
    this.phoneNumber,
    this.address,
    this.pinCode,
    this.city,
    this.state,
    this.prefix,
    this.gender,
    this.startTime,
    this.duration,
    this.numberOfSlots,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userId,
    this.speciality,
    this.profilePic,
    this.qualification,
    this.unavailability,
    this.experience,
  });

  Name name;
  String id;
  String email;
  String phoneNumber;
  String address;
  String pinCode;
  String city;
  String state;
  String prefix;
  int gender;
  String startTime;
  int duration;
  int numberOfSlots;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String userId;
  String speciality;
  String profilePic;
  String qualification;
  List<String> unavailability;
  String experience;

  factory ListOfDoctors.fromJson(Map<String, dynamic> json) => ListOfDoctors(
    name: Name.fromJson(json["name"]),
    id: json["_id"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    pinCode: json["pin_code"],
    city: json["city"],
    state: json["state"],
    prefix: json["prefix"],
    gender: json["gender"],
    startTime: json["start_time"],
    duration: json["duration"],
    numberOfSlots: json["number_of_slots"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    userId: json["user_id"],
    speciality: json["speciality"],
    profilePic: json["profile_pic"],
    qualification: json["qualification"],
    unavailability: List<String>.from(json["unavailability"].map((x) => x)),
    experience: json["experience"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "_id": id,
    "email": email,
    "phone_number": phoneNumber,
    "address": address,
    "pin_code": pinCode,
    "city": city,
    "state": state,
    "prefix": prefix,
    "gender": gender,
    "start_time": startTime,
    "duration": duration,
    "number_of_slots": numberOfSlots,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "user_id": userId,
    "speciality": speciality,
    "profile_pic": profilePic,
    "qualification": qualification,
    "unavailability": List<dynamic>.from(unavailability.map((x) => x)),
    "experience": experience,
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
    lastName: json["last_name"] == null ? null : json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName == null ? null : lastName,
  };
}