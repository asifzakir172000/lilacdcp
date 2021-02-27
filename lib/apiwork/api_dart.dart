import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//login api
Future loginUser(String email, String password, String token) async {
  var status;
  var data;

  String url = "http://65.1.45.74:8181/user/login";

  final response = await http.post(url, headers: {
    "Accept": "Application/json",
  }, body: {
    'email': email,
    'password': password,
  });

  //postman api link:-> https://www.getpostman.com/collections/6fc526781a0fd0a9016f
  // var datatoken = prefs.getString('data');
  /*
  {
    "status": "success",
    "message": "User Login Successful",
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjAwYWQ1NTU4OGQzMjJmMWFmOGYwMTdhIn0sImlhdCI6MTYxMTY3NDYwMywiZXhwIjozNDExNjc0NjAzfQ.PN8dmrCd964qPXWlF14m9GmKm_XDme19Y9Wh5zJs06o"
}
   */
  Map<String, dynamic> respMap;
  bool isTokenSuccess = response.body.contains('data');
  if (isTokenSuccess) {
    respMap = json.decode(response.body);
    String token = respMap['data'];
    print("got token: -> $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    return respMap;
  } else {
    print("API Error:- ");
    return null;
  }

  // var datatoken = prefs.getString('Data');
  // print(datatoken);
  // print("token data is printing now $datatoken");
  // status = response.body.contains('error');
  // var convertedDataToJson = jsonDecode(response.body);
}

Future singUP(String first_name, String last_name, String email,
    String password, String user_type) async {
  var status;

  String url = "http://65.1.45.74:8181/user/signup";
  final response = await http.post(url, headers: {
    "Accept": "Application/json",
    HttpHeaders.authorizationHeader: 'data'
  }, body: {
    'first_name': first_name,
    'last_name': last_name,
    'email': email,
    'password': password,
    'user_type': user_type
  });
  status = response.body;
  var convertDataToJson = jsonDecode(response.body);

  bool isTokenSuccess = response.body.contains('data');
  if (isTokenSuccess) {
    return convertDataToJson;
  } else {
    Fluttertoast.showToast(
        msg: convertDataToJson['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Color(0xFF8e539c),
        textColor: Colors.white,
        fontSize: 15.0);
    return null;
  }
}

Future proUser(String token) async {
  var status;
  var data;

  String url = "http://65.1.45.74:8181/user/getPatientProfile";

  final response = await http.post(url, headers: {
    "Accept": "Application/json",
  }, );

  //postman api link:-> https://www.getpostman.com/collections/6fc526781a0fd0a9016f
  // var datatoken = prefs.getString('data');
  /*
  {
    "status": "success",
    "message": "User Login Successful",
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjAwYWQ1NTU4OGQzMjJmMWFmOGYwMTdhIn0sImlhdCI6MTYxMTY3NDYwMywiZXhwIjozNDExNjc0NjAzfQ.PN8dmrCd964qPXWlF14m9GmKm_XDme19Y9Wh5zJs06o"
}
   */
  Map<String, dynamic> respMap;
  bool isTokenSuccess = response.body.contains('data');
  if (isTokenSuccess) {
    respMap = json.decode(response.body);
    String token = respMap['data'];
    print("got token: -> $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    return respMap;
  } else {
    print("API Error:-  ${response.body}");
    Fluttertoast.showToast(
        msg: "API Error:-  ${response.body}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Color(0xFF8e539c),
        textColor: Colors.white,
        fontSize: 15.0);
    return null;
  }

  // var datatoken = prefs.getString('Data');
  // print(datatoken);
  // print("token data is printing now $datatoken");
  // status = response.body.contains('error');
  // var convertedDataToJson = jsonDecode(response.body);
}


Future PatientDashboardApi(String token) async {
  var status;
  var data;

  String url = "http://65.1.45.74:8181/user/patientDashboard";

  final response = await http.post(url, headers: {
    "Accept": "Application/json",
  }, body: {
    'email': "",
    'password': "",
  });

  //postman api link:-> https://www.getpostman.com/collections/6fc526781a0fd0a9016f
  // var datatoken = prefs.getString('data');
  /*
  {
    "status": "success",
    "message": "User Login Successful",
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjAwYWQ1NTU4OGQzMjJmMWFmOGYwMTdhIn0sImlhdCI6MTYxMTY3NDYwMywiZXhwIjozNDExNjc0NjAzfQ.PN8dmrCd964qPXWlF14m9GmKm_XDme19Y9Wh5zJs06o"
}
   */
  Map<String, dynamic> respMap;
  bool isTokenSuccess = response.body.contains('data');
  if (isTokenSuccess) {
    respMap = json.decode(response.body);
    print("API :-  "+ respMap.toString());
    return respMap;
  } else {
    print("API Error:-  ${response.body}");
    Fluttertoast.showToast(
        msg: "API Error:-  ${response.body}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Color(0xFF8e539c),
        textColor: Colors.white,
        fontSize: 15.0);
    return null;
  }

  // var datatoken = prefs.getString('Data');
  // print(datatoken);
  // print("token data is printing now $datatoken");
  // status = response.body.contains('error');
  // var convertedDataToJson = jsonDecode(response.body);
}
