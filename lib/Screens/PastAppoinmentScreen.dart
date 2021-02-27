import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lilacdcp/apiwork/models/PastAppData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';

class PastAppoint extends StatefulWidget {
  @override
  _PastAppointState createState() => _PastAppointState();
}

class _PastAppointState extends State<PastAppoint> {
  bool _loading = true;

  List<PastAppointData> _passData;

  Future<List<PastAppointData>> getPastAppTimeSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print('token from json:-> $datatoken');
    final String url = "http://65.1.45.74:8181/appointment/past";

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});
    Map<String, dynamic> respMapDoc = json.decode(response.body);
    print(response.body);
    print(response);
    setState(() {
      _passData = (respMapDoc['data'] as List)
          .map((e) => PastAppointData.fromJson(e))
          .toList();
      print("List converted Data:-> ${_passData.join("<>")}");

      _loading = false;
    });
    return _passData;
  }

  @override
  void initState() {
    super.initState();
    this.getPastAppTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: _loading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: _passData == null ? 0 : _passData.length,
                      itemBuilder: (context, index) {
                        // ListOfDoctors parser=userData[index];
                        final pass = _passData[index];

                        // you can change the format here
                        var dateFormat = DateFormat("hh:mm aa");

                        //for start time
                        var utcDate = dateFormat.format(DateTime.parse(pass
                            .timeSlot.startTime
                            .toString())); // pass the UTC time here
                        var localDate = dateFormat
                            .parse(utcDate, true)
                            .toLocal()
                            .toString();
                        String createdDateStart =
                            dateFormat.format(DateTime.parse(localDate));

                        //for end time
                        var utcDateend = dateFormat.format(DateTime.parse(pass
                            .timeSlot.endTime
                            .toString())); // pass the UTC time here
                        var localDateend = dateFormat
                            .parse(utcDateend, true)
                            .toLocal()
                            .toString();
                        String createdDateEnd =
                            dateFormat.format(DateTime.parse(localDateend));

                        //for the date
                        // var dateFormatForDate = DateFormat("dd-MM-yyyy");
                        // var utcDateForDate = dateFormatForDate.format(
                        //     DateTime.parse(pass.timeSlot.date
                        //         .toString())); // pass the UTC time here
                        // var localDateForDate = dateFormatForDate
                        //     .parse(utcDateForDate, true)
                        //     .toLocal()
                        //     .toString();
                        // String createdDateForDate = dateFormatForDate
                        //     .format(DateTime.parse(localDateForDate));

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                            elevation: 1.0,
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(8),
                                      child:
                                          Image.network("${pass.profilePic}", height: 70, width: 70,),),
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
                                                "${pass.doctorName}",
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
                                                "${pass.timeSlot.date}",
                                                // parser.email,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              )),
                                          Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                    createdDateStart,
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
                                                    createdDateEnd,
                                                    // parser.email,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FlatButton(
                                        onPressed: () {},
                                        color: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Complete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }))),
    );
  }

// _dateConvert(){
//   var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
//   var utcDate = dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
//   var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
//   String createdDate = dateFormat.format(DateTime.parse(localDate));
// }
}
