import 'package:intl/intl.dart';
import 'package:lilacdcp/apiwork/models/PatientDashboard.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/dateHome.dart';
import 'package:lilacdcp/apiwork/models/ListOfDoctor.dart';
import 'package:lilacdcp/widgets/star.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

class PatientDashboardItem extends StatefulWidget {
  @override
  _PatientDashboardItemState createState() => _PatientDashboardItemState();
}

class _PatientDashboardItemState extends State<PatientDashboardItem> {
  List<PatientDashboard> doctors;
  bool _loading = true;

  Future<List<PatientDashboard>> getDoctorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final String url = "http://65.1.45.74:8181/user/patientDashboard";
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});
    print(response.body);
    Map<String, dynamic> respMapDoc = json.decode(response.body);
    setState(() {
      doctors =
          (respMapDoc['data']).map((e) => ListOfDoctors.fromJson(e)).toList();

      _loading = false;
      print("List converted Data:-> ${doctors.join("<>")}");
      // _loading = false;
    });
    print("PatientDashboard" + response.body);
    return doctors;
  }

  @override
  void initState() {
    super.initState();
    this.getDoctorData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: _loading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    // ListOfDoctors parser=userData[index];
                    final doc = doctors[index];

                    // // you can change the format here
                    var dateFormat = DateFormat("hh:mm aa");
                    //for start time
                    var utcDate = dateFormat.format(DateTime.parse(doc
                        .timeSlot.startTime
                        .toString())); // pass the UTC time here
                    var localDate =
                        dateFormat.parse(utcDate, true).toLocal().toString();
                    String _startTime =
                        dateFormat.format(DateTime.parse(localDate));

                    //for end time
                    var utcDateend = dateFormat.format(DateTime.parse(doc
                        .timeSlot.endTime
                        .toString())); // pass the UTC time here
                    var localDateend =
                        dateFormat.parse(utcDateend, true).toLocal().toString();
                    String _endTime =
                        dateFormat.format(DateTime.parse(localDateend));

                    //for the date
                    // var dateFormatForDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
                    // var utcDateForDate = dateFormatForDate.format(
                    //     DateTime.parse(pass.timeSlot.date.toString())); // pass the UTC time here
                    // var localDateForDate = dateFormatForDate.parse(utcDateForDate, true).toLocal().toString();
                    // String createdDateForDate = dateFormatForDate.format(DateTime.parse(localDateForDate));

                    return Container(
                      color: Colors.white,
                      child: Padding(
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
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage('assets/doc_image2.webp'),
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
                                              "${doc.doctorName}",
                                              // parser.email,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text(
                                                  '11:00 AM',
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
                                                    const EdgeInsets.all(4),
                                                child: Text(
                                                  '25-02-2021',
                                                  // parser.email,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                )),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Icon(
                                                Icons.videocam,
                                                color: kPrimaryColor,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
