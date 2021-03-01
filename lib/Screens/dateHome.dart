import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:lilacdcp/Screens/Fill_questionnaire.dart';
import 'package:lilacdcp/Screens/addamiy.dart';
import 'package:lilacdcp/apiwork/models/TimeSlots.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  final String id;
  final String dctrspeciality;
  final String dctrname;
  final String pro;
  

  const Home(this.id, this.dctrspeciality, this.dctrname, this.pro);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;

  List<TimeSlots> times;

  TimeSlots _time;
  List slots;

  Future<List<TimeSlots>> getTimeSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final String url = "http://65.1.45.74:8181/doctor/get-available-time-slots";
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken},
        body: {'doctor_id': widget.id});

    Map<String, dynamic> respMapDoc = json.decode(response.body);
    setState(() {
      times = (respMapDoc['data'] as List)
          .map((e) => TimeSlots.fromJson(e))
          .toList();
      print(times);
      final cat = times[0];
      slots = cat.timeSlots;
      print(slots);
      print("List converted Data:-> ${times.join("<>")}");
      _loading = false;
    });
    return times;
  }

  //booking api
  Future bookingApp(String start_time, String date) async {
    var status;
    var data;
    String url = "http://65.1.45.74:8181/appointment/book";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final response = await http.post(url, headers: {
      "token": datatoken,
      "Accept": "Application/json",
    }, body: {
      'doctor_id': widget.id,
      'start_time': start_time,
      'date': date,
    });
    /*
 {
    "status": "success",
    "message": "Appointment Booked"
}
 */
    status = response.body;
    print(status);
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

//use it manipulate lower part of screen.
  int mainIndex = 0;
  int subIndex = 0;
  int first = 0;

  @override
  void initState() {
    super.initState();
    this.getTimeSlots();
  }

  void showCurrentIndexData(int index) {
    setState(() {
      mainIndex = index;
    });
  }

  void showCurrentSubIndexData(int index) {
    setState(() {
      subIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.purple[100]]),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "My Bookings",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10),
            //doctor profile code
            Container(
              child: Column(children: [
                SizedBox(height: 20.0),
                Image.network(widget.pro, height: 150, width: 150,),
                SizedBox(height: 20.0),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.dctrname,
                        style: TextStyle(
                            fontFamily: 'poppins_regular',
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                    Text(widget.dctrspeciality,
                        style: TextStyle(
                            fontFamily: 'poppins_regular',
                            fontSize: 15,)),
                  ],
                ))
              ]),
            ),
            SizedBox(height: 30.0),

            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    'Select Date',
                    // parser.email,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins_regular',
                        color: Colors.black),
                  )),
            ),

            Center(
                child: Container(
                    height: 50,
                    child: _loading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: times == null ? 0 : times.length,
                            itemBuilder: (context, index) {
                              final cat = times[index];
                              // setState(() {
                              //   if(first == 0){
                              //     slots = cat.timeSlots;
                              //   }
                              // });
                              return Container(
                                margin: const EdgeInsets.all(8),
                                child: FlatButton(
                                    color: mainIndex == index
                                        ? kPrimaryColor
                                        : null,
                                    child: Text(
                                      cat.date,
                                      style: TextStyle(
                                          color: mainIndex == index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        slots = cat.timeSlots;
                                      });
                                      print("p = $slots");
                                      prefs.setString('datesp', cat.date);
                                      showCurrentIndexData(index);
                                      print(
                                          '${'printing current date'}${cat.date}');
                                    }),
                              );
                            }))),
            SizedBox(height: 10),

            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    'Select Time',
                    // parser.email,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins_regular',
                        color: Colors.black),
                  )),
            ),

            Center(
              child: _loading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                                childAspectRatio: 5/2,crossAxisSpacing: 2,mainAxisSpacing: 2),
                            itemCount: slots == null ? 0 : slots.length,
                            itemBuilder: (context, index) {
                              return FlatButton(
                                  color: subIndex == index
                                      ? kPrimaryColor
                                      : null,
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('timeslot', slots[index]);
                                    showCurrentSubIndexData(index);
                                    // setState(() {
                                    //   print(slots[index]);
                                    // });
                                  },
                                  child: Text(
                                    slots[index],
                                    style: TextStyle(
                                        color: subIndex == index
                                            ? Colors.white
                                            : Colors.black),
                                  ));
                            }),
                      ),
                    ),
              // :DropdownButton<String>(
              //     hint: Text(
              //       'Please select time slot',
              //       style: TextStyle(fontSize: 13),
              //     ),
              //     items:
              //         times[mainIndex].timeSlots.map((String value) {
              //       return new DropdownMenuItem<String>(
              //         onTap: () async {
              //           SharedPreferences prefs =
              //               await SharedPreferences.getInstance();
              //           prefs.setString('timeslot', value);
              //           print('printg now real $value ');
              //         },
              //         value: value,
              //         child: Text(value,
              //             style: TextStyle(
              //                 fontSize: 14.0,
              //                 fontWeight: FontWeight.w700,
              //                 color: Colors.black)),
              //       );
              //     }).toList(),
              //     onChanged: (_) {
              //       print('near of project');
              //     },
              //   ),
            ),
            SizedBox(height: 40),

            //two buttons in same line

            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        color: kPrimaryColor,
                        child: Ink(
                          child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Add Family Member",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)  {
                    return AddFamily();
                  }))
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        color: kPrimaryColor,
                        child: Ink(
                          child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Fill Questionnaire",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)  {
                    return FillQuestionnaire();
                  }))
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 40),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var timeslotsp = prefs.getString('timeslot');
                  var getdatesp = prefs.getString('datesp');
                  print('time slotdata now printing:-> $timeslotsp');
                  print('date slot data now printing:-> $getdatesp');
                  // _onAppoinmentScreen();
                  var rsp = await bookingApp(timeslotsp, getdatesp);
                  print(rsp);
                  bookingApp(timeslotsp, getdatesp);
                  if (rsp['status'] == 'success') {
                    _showAlertDailog('Message', 'Booking Done Successfully');
                  } else {
                    _showAlertDailog('Message', 'Booking Fail');
                  }
                  print('on pressed working on button:->');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, Colors.purple[100]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Book appoinment",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            // SizedBox(height: 20),
            // Padding(
            //     padding: const EdgeInsets.all(12),
            //     child: RaisedButton(
            //       onPressed: () async {
            //         // _showAlertDailog('Message', 'Booking Done Successfully');
            //         // var rsp = await bookingApp(timeslotsp, getdatesp);
            //         // print(rsp);
            //         SharedPreferences prefs =
            //             await SharedPreferences.getInstance();
            //         var timeslotsp = prefs.getString('timeslot');
            //         var getdatesp = prefs.getString('datesp');
            //         print('time slotdata now printing:-> $timeslotsp');
            //         print('date slot data now printing:-> $getdatesp');
            //         // _onAppoinmentScreen();
            //         var rsp = await bookingApp(timeslotsp, getdatesp);
            //         print(rsp);
            //         bookingApp(timeslotsp, getdatesp);
            //         if (rsp['status'] == 'success') {
            //           _showAlertDailog('Message', 'Booking Done Successfully');
            //         } else {
            //           _showAlertDailog('Message', 'Booking Fail');
            //         }
            //         print('on pressed working on button:->');
            //       },
            //       child: Text('Book appoinment',
            //           style: TextStyle(fontFamily: 'poppins_regular')),
            //       textColor: Colors.white,
            //       color: Colors.purple,
            //     ))
          ],
        ),
      ),
    ));
  }

  void _showAlertDailog(String title, String message) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
