import 'package:lilacdcp/uti/constants.dart';
import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/dateHome.dart';
import 'package:lilacdcp/apiwork/models/ListOfDoctor.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorItem extends StatefulWidget {
  @override
  _DoctorItemState createState() => _DoctorItemState();
}

class _DoctorItemState extends State<DoctorItem> {
  List<ListOfDoctors> doctors;
  bool _loading = true;

  Future<List<ListOfDoctors>> getDoctorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final String url = "http://65.1.45.74:8181/doctor/get-all";
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});
    Map<String, dynamic> respMapDoc = json.decode(response.body);
    setState(() {
      doctors = (respMapDoc['data'] as List)
          .map((e) => ListOfDoctors.fromJson(e))
          .toList();
      
      _loading = false;
      print("List converted Data:-> ${doctors.join("<>")}");
      // _loading = false;
    });
    print("List1" + response.body);
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
                    // _getDocId() async{
                    //   SharedPreferences prefs = await SharedPreferences.getInstance();
                    //   prefs.setString('docId', doc.id);
                    //  docID = prefs.getString('docId');
                    //   print(docID);
                    // }
                    String name;
                                      if (doc.name.lastName == null) {
                                        name = "Dr. " +doc.name.firstName;
                                      } else {
                                        name = "Dr. " +doc.name.firstName + " " + doc.name.lastName ;
                                      }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Card(
                          elevation: 1.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home(
                                    doc.id, doc.speciality, name, doc.profilePic);
                              }));
                              // print('tapping:->');
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.network(
                                      '${doc.profilePic}',
                                      height: 70,
                                      width: 70,
                                    )),
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
                                              name,
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
                                              '${doc.speciality}',
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
                                                          const EdgeInsets.all(4),
                                                      child: Text(
                                                        '${'Exp: '}${doc.experience}${' yrs'}',
                                                        // parser.email,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      )),
                                                  //   Container(
                                                  //     color: Colors.grey,
                                                  //     height: 15,
                                                  //     width: 1,
                                                  //   ),
                                                  //   Padding(
                                                  //       padding:
                                                  //           const EdgeInsets.all(
                                                  //               4),
                                                  //       child: Text(
                                                  //         '${'_endTime'}',
                                                  //         // parser.email,
                                                  //         style: TextStyle(
                                                  //             fontSize: 14,
                                                  //             color: Colors.grey),
                                                  //       )),
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: Align(
                                            //     alignment: Alignment.topRight,
                                            //     child: Container(
                                            //       child: IconTheme(
                                            //         data: IconThemeData(
                                            //           color: Colors.amber,
                                            //           size: 20,
                                            //         ),
                                            //         child: StarDisplay(value: 3),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
        ),
      ),
    );
  }
}
