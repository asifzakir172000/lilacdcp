import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lilacdcp/apiwork/models/PatientDashboardModle.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpComingWidget extends StatefulWidget {
  @override
  _UpComingWidgetState createState() => _UpComingWidgetState();
}

class _UpComingWidgetState extends State<UpComingWidget> {
  bool _loading = true;

  var _getNumberOfBooking, _getTotalEarnings, _getUpcomingBooking;
  // List<UpcomingOneModel> _upcomingData;

  // Future getDataFromApi() async{
  //   final String url = "http://65.1.45.74:8181/doctor/dashboard";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var datatoken = prefs.getString('token');
  //   http.Response response = await http.post(
  //       Uri.encodeFull(url),
  //       headers: {"Accept": "application/json", "token": datatoken}
  //   );
  //
  //   String responseData=response.body;
  //   int  finaldata1=jsonDecode(responseData)["data"]["number_of_bookings"];
  //   int  finaldata2=jsonDecode(responseData)["data"]["upcoming_count"];
  //   var  finaldata3=jsonDecode(responseData)["data"]["total_earnings"];
  //
  //   // print("printing data object: -> $finaldata1");
  //
  //   setState(() {
  //     _getNumberOfBooking =finaldata1;
  //     _getTotalEarnings =finaldata2;
  //     _getUpcomingBooking =finaldata3;
  //   });
  //   return responseData;
  // }

  // Future<List<UpcomingOneModel>> getUpcomingAppTimeScreen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var datatoken = prefs.getString('token');
  //   print('token from json:-> $datatoken');
  //   final String url = "http://65.1.45.74:8181/user/patientDashboard";
  //
  //   var response = await http.post(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json", "token": datatoken});
  //   String responseData=response.body;
  //   print("Printing response:-> ${responseData}");
  //
  //   int  finaldata1=jsonDecode(responseData)["data"]["number_of_bookings"];
  //   int  finaldata2=jsonDecode(responseData)["data"]["upcoming_count"];
  //   var  finaldata3=jsonDecode(responseData)["data"]["total_earnings"];
  //
  //   // Map<String, dynamic> respMapDoc = json.decode(response.body.toString());
  //   // // print("Printing response ${response.body}");
  //   // List<dynamic> data = respMapDoc["upcoming_appointment"];
  //   Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
  //
  //   print(data['patient_name']);
  //   print("gettting data from server:__>${data['patient_name']}");
  //   setState(() {
  //
  //
  //     // _upcomingData = (respMapDoc['upcoming_appointment'] as List)
  //     //     .map((e) => UpcomingOneModel.fromJson(e))
  //     //     .toList();
  //     // print("List converted Data:-> ${_upcomingData.join("<>")}");
  //     //
  //     // _loading = false;
  //   });
  //   return _upcomingData;
  // }
  //

  // Future<List<UpcomingOneModel>> getUpcomingAppTimeScreen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var datatoken = prefs.getString('token');
  //   print(datatoken);
  //
  //   final String url = "http://65.1.45.74:8181/user/getDoctorProfile";
  //   var response = await http.post(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json", "token": datatoken});
  //   Map<String, dynamic> respMapDoc = json.decode(response.body);
  //   setState(() {
  //
  //     _upcomingData = (respMapDoc['data'] as List)
  //         .map((e) => UpcomingOneModel.fromJson(e))
  //         .toList();
  //     print("List converted Data:-> ${_upcomingData.join("<>")}");
  //     _loading = false;
  //   });
  //
  //   return _upcomingData;
  // }

  // Future<List<UpcomingOneModel>> getData() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var datatoken = prefs.getString('token');
  //     // print('token from json:-> $datatoken');
  //     final String url = "http://65.1.45.74:8181/user/patientDashboard";
  //     List<UpcomingOneModel> list;
  //     var response = await http.post(Uri.encodeFull(url),
  //         headers: {"Accept": "application/json", "token": datatoken});
  //
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     // var data = json.decode(response.body);
  //     // var rest = data["upcoming_appointment"] as List;
  //     // print(rest);
  //     List responseJson = json.decode(response.body);
  //     return responseJson.map((m) => new UpcomingOneModel.fromJson(m)).toList();
  //   }
  //   print("List Size: ${list.length}");
  //   return list;
  // }

  // Future<List<Map<String, dynamic>>> fetch() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var datatoken = prefs.getString('token');
  //   // print('token from json:-> $datatoken');
  //   final String url = "http://65.1.45.74:8181/user/patientDashboard";
  //
  //   http.Response response = await http.post(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json", "token": datatoken});
  //   String responseData=response.body;
  //   if (response.statusCode != 200) return null;
  //   return List<Map<String, dynamic>>.from(json.decode(responseData)['data']);
  // }

  Future getDataFromApi() async {
    final String url = "http://65.1.45.74:8181/user/patientDashboard";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    http.Response response = await http.post(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});

    String responseData = response.body;
    List finaldata1 = jsonDecode(responseData)["data"]["upcoming_appointment"];
    List finaldata2 = jsonDecode(responseData)["data"]["upcoming_appointment"];
    // List<PatientDashboardModle> g = jsonDecode(responseData)["data"]["upcoming_appointment"];
    // const CustomDateTimeConverter().finaldata2.
    // int  finaldata2=jsonDecode(responseData)["data"]["upcoming_count"];
    // var  finaldata3=jsonDecode(responseData)["data"]["total_earnings"];

    print("printing data object: -> $finaldata1");
    print(
        "printing data object: -> ${jsonDecode(responseData)["data"]["upcoming_appointment"][0]['time_slot']['date']}");

    setState(() {
      _getNumberOfBooking = finaldata1;
      // _getTotalEarnings =finaldata2;
      // _getUpcomingBooking =finaldata3;
    });

    return responseData;
  }

  @override
  void initState() {
    super.initState();
    this.getDataFromApi();
  }

  // Widget listViewWidget(List<UpcomingOneModel> article) {
  //   return Container(
  //     child: ListView.builder(
  //         itemCount: 20,
  //         padding: const EdgeInsets.all(2.0),
  //         itemBuilder: (context, position) {
  //           return Card(
  //             child: ListTile(
  //               title: Text(
  //                 '${article[position]}',
  //                 style: TextStyle(
  //                     fontSize: 18.0,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               leading: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: SizedBox(
  //                   child: article[position].doctorName == null
  //                       ? Image(
  //                     image: AssetImage('images/no_image_available.png'),
  //                   )
  //                       : Image.network('${article[position].profilePic}'),
  //                   height: 100.0,
  //                   width: 100.0,
  //                 ),
  //               ),
  //               onTap: () => _onTapItem(context, article[position]),
  //             ),
  //           );
  //         }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: getDataFromApi(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length.compareTo(0),
                      itemBuilder: (context, index) {
                        // // // you can change the format here
                        // var dateFormat = DateFormat("hh:mm aa");
                        // //for start time
                        //  var asif= HttpDate.parse(_getNumberOfBooking[index]['start_time'].toString());
                        // Fluttertoast.showToast(
                        //   msg: "API Error:-  ${_getNumberOfBooking[0]['time_slot']['date']}",
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   gravity: ToastGravity.BOTTOM,
                        //   timeInSecForIosWeb: 1,
                        //   // backgroundColor: Color(0xFF8e539c),
                        //   textColor: Colors.white,
                        //   fontSize: 15.0);
                        // var utcDate = dateFormat.format(DateTime.parse()); // pass the UTC time here
                        // var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
                        // String _startTime = dateFormat.format(DateTime.parse(localDate));
                        //
                        // //for end time
                        // var utcDateend = dateFormat.format(DateTime.parse(_getNumberOfBooking[index]['end_time'].toString()).toLocal()); // pass the UTC time here
                        // var localDateend = dateFormat.parse(utcDateend, true).toLocal().toString();
                        // String _endTime = dateFormat.format(DateTime.parse(localDateend));

                        var startTime = _getNumberOfBooking[index]['time_slot']
                                ['start_time']
                            .toString();
                        var endTime = _getNumberOfBooking[index]['time_slot']
                                ['end_time']
                            .toString();

                        var dateFormat = DateFormat("hh:mm aa");
                        //for start time
                        var utcDate = dateFormat.format(DateTime.parse(
                            startTime)); // pass the UTC time here
                        var localDate = dateFormat
                            .parse(utcDate, true)
                            .toLocal()
                            .toString();
                        String _startTime =
                            dateFormat.format(DateTime.parse(localDate));

                        //for end time
                        var utcDateend = dateFormat.format(
                            DateTime.parse(endTime)); // pass the UTC time here
                        var localDateend = dateFormat
                            .parse(utcDateend, true)
                            .toLocal()
                            .toString();
                        String _endTime =
                            dateFormat.format(DateTime.parse(localDateend));

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          elevation: 1.0,
                          child: InkWell(
                            onTap: () {
                              print('printing on past appoinment:->');
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.network(
                                    _getNumberOfBooking[index]['profile_pic'],
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              _getNumberOfBooking[index]
                                                      ['doctor_name']
                                                  .toString(),
                                              // parser.email,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              _getNumberOfBooking[index]
                                                      ['time_slot']['date']
                                                  .toString(),
                                              // parser.email,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            )),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Text(
                                                        _startTime,
                                                        // parser.email,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      )),
                                                  Container(
                                                    color: Colors.grey,
                                                    height: 15,
                                                    width: 1,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Text(
                                                        _endTime,
                                                        // parser.email,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Icon(
                                                    Icons.videocam,
                                                    color: kPrimaryColor,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        // Text(_getNumberOfBooking[index]['doctor_name'].toString());
                      });

                  //   Container(
                  //     // child:  Center(
                  //     //   child:_loading
                  //     //       ? CircularProgressIndicator()
                  // //           :
                  // // FutureBuilder<List<Map<String, dynamic>>>(
                  // // future: _future,
                  // // builder: (context, snapshot) {
                  // //   return
                  // Padding(
                  // //     padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  // //     child: Card(
                  // //       shape: RoundedRectangleBorder(
                  // //           borderRadius: BorderRadius.all(Radius.circular(10),)),
                  // //       elevation: 2.0,
                  // //       child: InkWell(
                  // //         onTap: () {
                  // //           print('printing on past appoinment:->');
                  // //         },
                  // //         child:
                  // //         Row(
                  // //           children: <Widget>[
                  // //             Padding(
                  // //               padding: const EdgeInsets.all(8),
                  // //               child:
                  // //               CircleAvatar(
                  // //                 backgroundColor: Colors.white,
                  // //                 backgroundImage: NetworkImage(
                  // //                     upcoming.upcomingAppointment[index].patientName),
                  // //               ),
                  // //             ),
                  // //             Expanded(
                  // //               child: Padding(
                  // //                 padding: const EdgeInsets.all(8),
                  // //                 child: Column(
                  // //                   crossAxisAlignment: CrossAxisAlignment.start,
                  // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //                   children: <Widget>[
                  // //                     Padding(
                  // //                         padding: const EdgeInsets.all(4),
                  // //                         child: Text(
                  // //                           upcoming.upcomingAppointment[index].status,
                  // //                           // parser.email,
                  // //                           style: TextStyle(
                  // //                               fontSize: 16,
                  // //                               color: Colors.black,
                  // //                               fontWeight: FontWeight.bold),
                  // //                         )),
                  // //                     Row(
                  // //                       children: [
                  // //                         Padding(
                  // //                             padding: const EdgeInsets.all(4),
                  // //                             child: Text("_startTime",
                  // //                               // parser.email,
                  // //                               style: TextStyle(
                  // //                                   fontSize: 14, color: Colors.grey),
                  // //                             )),
                  // //                         Container(
                  // //                           color: Colors.grey, height: 15, width: 1,),
                  // //                         Padding(
                  // //                             padding: const EdgeInsets.all(4),
                  // //                             child: Text(upcoming.upcomingAppointment[index]
                  // //                                 .docSpeciality,
                  // //                               // parser.email,
                  // //                               style: TextStyle(
                  // //                                   fontSize: 14, color: Colors.grey),
                  // //                             )),
                  // //                       ],
                  // //                     ),
                  // //
                  // //                     Align(
                  // //                       alignment: Alignment.topRight,
                  // //                       child: Padding(
                  // //                           padding: const EdgeInsets.only(left: 8),
                  // //                           child: Icon(Icons.videocam, color: appColor,)),
                  // //                     )
                  // //                   ],
                  // //                 ),
                  // //               ),
                  // //             ),
                  // //           ],
                  // //         ),
                  // //       ),
                  // //     ),
                  // //   );
                  // // }
                  // //           ),
                  //     ),
                  // ) ,
                })));
  }
}
