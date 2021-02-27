// To parse this JSON data, do
//
//     final timesSlotsData = timesSlotsDataFromJson(jsonString);

import 'dart:convert';

// TimesSlotsData timesSlotsDataFromJson(String str) => TimesSlotsData.fromJson(json.decode(str));
//
// String timesSlotsDataToJson(TimesSlotsData data) => json.encode(data.toJson());

class TimesSlotsData {
  TimesSlotsData({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory TimesSlotsData.fromJson(Map<String, dynamic> json) => TimesSlotsData(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.date,
    this.timeSlots,
  });

  String date;
  List<String> timeSlots;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    timeSlots: List<String>.from(json["time_slots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "time_slots": List<dynamic>.from(timeSlots.map((x) => x)),
  };
}
