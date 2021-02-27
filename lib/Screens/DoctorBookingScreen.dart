

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lilacdcp/apiwork/models/TimeSlots.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AppiontmentsScreen.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'dateHome.dart';
import 'package:image_picker/image_picker.dart';

class BookingScreen extends StatefulWidget {
  final String id;
  final String dctrname;
  final String dctrspeciality;

  BookingScreen(this.id, this.dctrname, this.dctrspeciality);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String catie = "Doc Time Slot:->";

  // File _image;
  bool _loading = true;

  List<TimeSlots> times;

  // Future getImage() async{
  //   final image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = image;
  //   });
  // }

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

  @override
  void initState() {
    super.initState();
    this.getTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor booking',
            style: TextStyle(fontFamily: 'poppins_regular', fontSize: 16)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.purple[100]]),
          ),
        ),
      ),
      body: Home(widget.id, widget.dctrspeciality, widget.dctrname),
    );
    // SingleChildScrollView(
    //     child:
    //     Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //       //doctor profile code
    //       Container(
    //         child: Column(children: [
    //           SizedBox(height: 20.0),
    //           CircleAvatar(
    //             child: Text('DC'),
    //           ),
    //           SizedBox(height: 5.0),
    //           Center(
    //               child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(widget.dctrspeciality,
    //                   style: TextStyle(
    //                       fontFamily: 'poppins_regular', fontSize: 16)),
    //               Text(widget.dctrname,
    //                   style: TextStyle(
    //                       fontFamily: 'poppins_regular', fontSize: 16)),
    //             ],
    //           ))
    //         ]),
    //       ),
    //       SizedBox(height: 20.0),
    //
    //       //week date code
    //       Container(
    //         height: 50.0,
    //         child: ListView.builder(
    //           scrollDirection: Axis.horizontal,
    //           shrinkWrap: true,
    //           itemCount: times == null ? 0 : times.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             TimeSlots cat = times[index];
    //             return InkWell(
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(8.0)),
    //                 elevation: 2.0,
    //                 child: Padding(
    //                   padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //                   child: Row(children: <Widget>[
    //                     Padding(
    //                         padding: const EdgeInsets.all(5),
    //                         child: Text(
    //                           cat.date,
    //                           style: TextStyle(
    //                             fontFamily: 'poppins_regular',
    //                             fontWeight: FontWeight.w900,
    //                             fontSize: 14,
    //                           ),
    //                         ))
    //                   ]),
    //                 ),
    //               ),
    //               onTap: () async {
    //                 SharedPreferences prefs =
    //                     await SharedPreferences.getInstance();
    //                 prefs.setString('datesp', cat.date);
    //                 print(cat.date);
    //               },
    //             );
    //             //   OneWeekDate(
    //             //   title: cat.date,
    //             //   isHome: false,
    //             //   tap: () {
    //             //     // setState((){catie = "${cat['name']}";});
    //             //   },
    //             // );
    //           },
    //         ),
    //       ),
    //       Divider(),
    //       Text(
    //         "$catie",
    //         style: TextStyle(
    //           fontSize: 14,
    //           fontWeight: FontWeight.w700,
    //         ),
    //       ),
    //       SizedBox(height: 4.0),
    //
    //       ListView.builder(
    //         shrinkWrap: true,
    //         primary: false,
    //         physics: NeverScrollableScrollPhysics(),
    //         itemCount: times == null ? 0 : times.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           TimeSlots timesslot = times[index];
    //           print(timesslot.timeSlots[index].toString());
    //           return Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 InkWell(
    //                   child: Card(
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(8.0)),
    //                       elevation: 2,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8),
    //                         child: Text(
    //                           timesslot.timeSlots[index],
    //                           style: TextStyle(
    //                             fontSize: 14.0,
    //                             fontWeight: FontWeight.w700,
    //                           ),
    //                         ),
    //                       )),
    //                   onTap: () async {
    //                     SharedPreferences prefs =
    //                         await SharedPreferences.getInstance();
    //                     prefs.setString(
    //                         'timeslot', timesslot.timeSlots[index]);
    //                     print(timesslot.timeSlots[index]);
    //                   },
    //                 )
    //               ]);
    //           // TimeSlotsClass(timesslot.timeSlots[index].toString());
    //         },
    //       ),
    //       SizedBox(height: 10),
    //       Padding(
    //           padding: const EdgeInsets.all(12),
    //           child:
    //           RaisedButton(
    //
    //             onPressed: () async {
    //               // var rsp = await bookingApp(timeslotsp, getdatesp);
    //               // print(rsp);
    //               SharedPreferences prefs = await SharedPreferences.getInstance();
    //               var timeslotsp = prefs.getString('timeslot');
    //               var getdatesp = prefs.getString('datesp');
    //               print('time slotdata now printing:-> $timeslotsp');
    //               print('date slot data now printing:-> $getdatesp');
    //               // _onAppoinmentScreen();
    //               var rsp = await bookingApp(timeslotsp, getdatesp);
    //               print(rsp);
    //               bookingApp(timeslotsp, getdatesp);
    //             if (rsp['status'] == 'success') {
    //               Fluttertoast.showToast(
    //                   msg: "Appoinment booked successfully",
    //                   toastLength: Toast.LENGTH_SHORT,
    //                   gravity: ToastGravity.BOTTOM,
    //                   timeInSecForIosWeb: 1,
    //                   backgroundColor: Colors.purple,
    //                   textColor: Colors.white,
    //                   fontSize: 14.0
    //               );
    //             }else{
    //               Fluttertoast.showToast(
    //                   msg: "Appoinment booked fail",
    //                   toastLength: Toast.LENGTH_SHORT,
    //                   gravity: ToastGravity.BOTTOM,
    //                   timeInSecForIosWeb: 1,
    //                   backgroundColor: Colors.purple,
    //                   textColor: Colors.white,
    //                   fontSize: 14.0
    //               );
    //             }
    //
    //
    //
    //               print('on pressed working on button:->');
    //             },
    //             child: Text('Book appoinment',
    //                 style: TextStyle(fontFamily: 'poppins_regular')),
    //             textColor: Colors.white,
    //             color: Colors.purple,
    //           ))
    //     ])));
  }

  _onAppoinmentScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AppointmentScreen();
    }));
  }
}
