// To parse this JSON data, do
//
//     final timeSlots = timeSlotsFromJson(jsonString);

import 'dart:convert';

// List<TimeSlots> timeSlotsFromJson(String str) => List<TimeSlots>.from(json.decode(str).map((x) => TimeSlots.fromJson(x)));
//
// String timeSlotsToJson(List<TimeSlots> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSlots {
  TimeSlots({
    this.date,
    this.timeSlots,
  });

  String date;
  List<String> timeSlots;

  factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
    date: json["date"],
    timeSlots: List<String>.from(json["time_slots"].map((e) => e)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "time_slots": List<dynamic>.from(timeSlots.map((e) => e)),
  };
}
