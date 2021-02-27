import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/dateconevt.dart';
import 'package:lilacdcp/apiwork/models/UpcomingAppData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class UpcomingAppoint extends StatefulWidget {
  @override
  _UpcomingAppointState createState() => _UpcomingAppointState();
}

class _UpcomingAppointState extends State<UpcomingAppoint> {
  bool _loading = true;

  List<UpcomingAppointData> _upcomingData;

  Future<List<UpcomingAppointData>> getUpcomingAppTimeSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print('token from json:-> $datatoken');
    final String url = "http://65.1.45.74:8181/appointment/upcoming";

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});
    Map<String, dynamic> respMapDoc = json.decode(response.body);
    print(response.body);
    print(response);
    setState(() {
      _upcomingData = (respMapDoc['data'] as List)
          .map((e) => UpcomingAppointData.fromJson(e))
          .toList();
      print("List converted Data:-> ${_upcomingData.join("<>")}");

      _loading = false;
    });
    return _upcomingData;
  }

  Future<void> _refreshGetUpcomingAppTimeSlots(BuildContext context) async {
    return getUpcomingAppTimeSlots();
  }

  @override
  void initState() {
    super.initState();
    this.getUpcomingAppTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RefreshIndicator(
            onRefresh: () => _refreshGetUpcomingAppTimeSlots(context),
            child: _loading
                ?
                // Shimmer.fromColors(
                //     direction: ShimmerDirection.rtl,
                //     period: Duration(seconds: 5),
                //     child: Column(
                //       children: [0, 1, 2, 3]
                //           .map((_) => Padding(
                //         padding:
                //         const EdgeInsets.all(16),
                //         child: Row(
                //           crossAxisAlignment:
                //           CrossAxisAlignment.start,
                //           children: [
                //             Container(
                //               width: 48.0,
                //               height: 48.0,
                //               color: Colors.white,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 8.0),
                //             ),
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment:
                //                 CrossAxisAlignment.start,
                //                 children: [
                //                   Container(
                //                     width: double.infinity,
                //                     height: 8.0,
                //                     color: Colors.white,
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets
                //                         .symmetric(vertical: 2.0),
                //                   ),
                //                   Container(
                //                     width: double.infinity,
                //                     height: 8.0,
                //                     color: Colors.white,
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets
                //                         .symmetric(vertical: 2.0),
                //                   ),
                //                   Container(
                //                     width: 40.0,
                //                     height: 8.0,
                //                     color: Colors.white,
                //                   ),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       ))
                //           .toList(),
                //     ),
                //     baseColor: Colors.grey[400],
                //     highlightColor: Colors.grey[100])
                CircularProgressIndicator()
                : ListView.builder(
                    itemCount: _upcomingData == null ? 0 : _upcomingData.length,
                    itemBuilder: (context, index) {
                      // ListOfDoctors parser=userData[index];
                      final pass = _upcomingData[index];

                      // // you can change the format here
                      var dateFormat = DateFormat("hh:mm aa");
                      //for start time
                      var utcDate = dateFormat.format(DateTime.parse(pass
                          .timeSlot.startTime
                          .toString())); // pass the UTC time here
                      var localDate =
                          dateFormat.parse(utcDate, true).toLocal().toString();
                      String _startTime =
                          dateFormat.format(DateTime.parse(localDate));

                      //for end time
                      var utcDateend = dateFormat.format(DateTime.parse(pass
                          .timeSlot.endTime
                          .toString())); // pass the UTC time here
                      var localDateend = dateFormat
                          .parse(utcDateend, true)
                          .toLocal()
                          .toString();
                      String _endTime =
                          dateFormat.format(DateTime.parse(localDateend));

                      //for the date
                      // var dateFormatForDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
                      // var utcDateForDate = dateFormatForDate.format(
                      //     DateTime.parse(pass.timeSlot.date.toString())); // pass the UTC time here
                      // var localDateForDate = dateFormatForDate.parse(utcDateForDate, true).toLocal().toString();
                      // String createdDateForDate = dateFormatForDate.format(DateTime.parse(localDateForDate));

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              print('printing on past appoinment:->');
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Image.network("${pass.profilePic}", height: 70, width: 70,)
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 4),
                                            child: Text(
                                              '${pass.doctorName}',
                                              // parser.email,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 4),
                                            child: Text(
                                              '${pass.timeSlot.date}',
                                              // parser.email,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Text(
                                                        '${_startTime}',
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
                                                        '${_endTime}',
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
                        ),
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
