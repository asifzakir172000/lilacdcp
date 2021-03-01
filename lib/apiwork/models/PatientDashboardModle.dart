// To parse this JSON data, do
//
//     final patientDashboardModle = patientDashboardModleFromJson(jsonString);

import 'dart:convert';

import 'package:lilacdcp/Screens/dateconevt.dart';

// List<PatientDashboardModle> patientDashboardModleFromJson(String str) => List<PatientDashboardModle>.from(json.decode(str).map((x) => PatientDashboardModle.fromJson(x)));

// String patientDashboardModleToJson(List<PatientDashboardModle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientDashboardModle {
    PatientDashboardModle({
        this.timeSlot,
        this.id,
        this.userId,
        this.patientName,
        this.doctorId,
        this.profilePic,
        this.status,
        this.doctorName,
        this.docSpeciality,
        this.roomName,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    TimeSlot timeSlot;
    String id;
    String userId;
    String patientName;
    String doctorId;
    String profilePic;
    String status;
    String doctorName;
    String docSpeciality;
    String roomName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory PatientDashboardModle.fromJson(Map<String, dynamic> json) => PatientDashboardModle(
        timeSlot: TimeSlot.fromJson(json["time_slot"]),
        id: json["_id"],
        userId: json["user_id"],
        patientName: json["patient_name"],
        doctorId: json["doctor_id"],
        profilePic: json["profile_pic"],
        status: json["status"],
        doctorName: json["doctor_name"],
        docSpeciality: json["doc_speciality"],
        roomName: json["room_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "time_slot": timeSlot.toJson(),
        "_id": id,
        "user_id": userId,
        "patient_name": patientName,
        "doctor_id": doctorId,
        "profile_pic": profilePic,
        "status": status,
        "doctor_name": doctorName,
        "doc_speciality": docSpeciality,
        "room_name": roomName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class TimeSlot {
    TimeSlot({
        this.date,
        this.startTime,
        this.endTime,
    });

    String date;
    DateTime startTime;
    DateTime endTime;

    factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    date: json["date"],
    startTime:
    // DateTime.parse(json["start_time"])
     const CustomDateTimeConverter().fromJson(json['start_time'] as String),
    endTime:
    // DateTime.parse(json["end_time"]),
    const CustomDateTimeConverter().fromJson(json['end_time'] as String),

  );

    Map<String, dynamic> toJson() => {
        "date": date,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
    };
}
