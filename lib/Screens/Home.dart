import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/DoctorListScreen.dart';
import 'package:lilacdcp/apiwork/models/PatientDashboard.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lilacdcp/widgets/PatientDashboardItem.dart';
import 'package:lilacdcp/widgets/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List icon = [
    "assets/gmo2.png",
    "assets/genetics7.png",
    "assets/genetics8.png",
  ];
  List name = [
    'Genetic\nCounselling',
    'Clinical\nGenentics',
    'Psychological\nCounselling',
  ];


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
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Stack(
              children:[
                Container(
          child: Column(
            children: [
              // search
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Container(
                  color: Colors.white70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Search pet to adopt'), Icon(Icons.search)],
                  ),
                ),
              ),

              //text 1
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.topLeft,
                child: Text("Upcoming Bookings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),

              //upcomming booing design

              // Expanded(
              //                 child: Container(
              //     child: PatientDashboardItem(),
              //   ),
              // )

              Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        'Dr. Rahul Sharma',
                                        // parser.email,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            '11:00 AM',
                                            // parser.email,
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.grey),
                                          )),
                                      Container(
                                        color: Colors.grey,
                                        height: 15,
                                        width: 1,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            '25-02-2021',
                                            // parser.email,
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.grey),
                                          )),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
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
              )

              //text 2
              ,
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Speciality",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => {},
                        child: Text("View More",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  )),

              //speci
              Container(
                height: 180,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: icon == null ? 0 : icon.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 180,
                          width: 180,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.grey[300],
                                        offset: Offset(0, 10),
                                        blurRadius: 30,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        icon[index],
                                        height: 70,
                                        width: 70,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(child: Text(name[index])),
                                    ],
                                  )),
                            ],
                          ));
                    }),
              ),

              //text 3
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.topLeft,
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Doctor List",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => {},
                        child: Text("View More",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ) 
              ),

              //doctor list
              Expanded(
                  child: Container(
                  child: DoctorItem(),
                ),
              )

            //   Expanded(
            //     child: Container(
            //       child: ListView.builder(
            //           itemCount: 5,
            //           itemBuilder: (context, index) {
            //             return Padding(
            //               padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
            //               child: Card(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.all(
            //                   Radius.circular(10),
            //                 )),
            //                 elevation: 2.0,
            //                 child: InkWell(
            //                   onTap: () {
            //                     print('printing on past appoinment:->');
            //                   },
            //                   child: Row(
            //                     children: <Widget>[
            //                       Padding(
            //                         padding: const EdgeInsets.all(8),
            //                         child: CircleAvatar(
            //                           backgroundColor: Colors.white,
            //                           backgroundImage:
            //                               AssetImage('assets/doc_image2.webp'),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Padding(
            //                           padding: const EdgeInsets.all(8),
            //                           child: Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceBetween,
            //                             children: <Widget>[
            //                               Padding(
            //                                   padding: const EdgeInsets.all(4),
            //                                   child: Text(
            //                                     'Dr. Rahul Sharma',
            //                                     // parser.email,
            //                                     style: TextStyle(
            //                                         fontSize: 16,
            //                                         color: Colors.black,
            //                                         fontWeight: FontWeight.bold),
            //                                   )),
            //                               Row(
            //                                 children: [
            //                                   Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(4),
            //                                       child: Text(
            //                                         '11:00 AM',
            //                                         // parser.email,
            //                                         style: TextStyle(
            //                                             fontSize: 14,
            //                                             color: Colors.grey),
            //                                       )),
            //                                   Container(
            //                                     color: Colors.grey,
            //                                     height: 15,
            //                                     width: 1,
            //                                   ),
            //                                   Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(4),
            //                                       child: Text(
            //                                         '25-02-2021',
            //                                         // parser.email,
            //                                         style: TextStyle(
            //                                             fontSize: 14,
            //                                             color: Colors.grey),
            //                                       )),
            //                                 ],
            //                               ),
            //                               Align(
            //                                 alignment: Alignment.topRight,
            //                                 child: Padding(
            //                                     padding: const EdgeInsets.only(
            //                                         left: 8),
            //                                     child: Icon(
            //                                       Icons.videocam,
            //                                       color: kPrimaryColor,
            //                                     )),
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }),
            //     ),
            //   ),
            ],
          ),
        ),
      
              ] 
              ),
    );
  }
}
