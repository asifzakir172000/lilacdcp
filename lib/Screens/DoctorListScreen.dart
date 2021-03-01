import 'package:flutter/material.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:lilacdcp/apiwork/models/ListOfDoctor.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dateHome.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<DoctorListScreen> {
  // final String url = "http://65.1.45.74:8181/doctor/get-all";
  List userData;
  bool _loading = true;
  String email = "";
  bool _visible = false;
  final nameController = TextEditingController();

  Future getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  List<ListOfDoctors> doctors;
  List<ListOfDoctors> filterDoctors = List<ListOfDoctors>();

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
      print("List converted Data:-> ${doctors.join("<>")}");
      _loading = false;
      filterDoctors = doctors;
      print("filterDoctors1  " + filterDoctors.toString());
      print("filterDoctors2  " + doctors.toString());
    });
    print("List" + response.body);
    return doctors;
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          _filterMovies(value);
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Search Doctor Here",
            hintStyle: TextStyle(color: Colors.black)),
      ),
    );
  }

  void _filterMovies(value) {
    setState(() {
      filterDoctors = doctors
          .where((country) =>
              country.speciality.toLowerCase().contains(value.toLowerCase()))
          .toList();

      print(value);
      print(filterDoctors.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    this.getDoctorData();
    // nameController.text = "genetic";
    // _filterMovies("ge");
  }

  String docID = '';

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
            "Doctor List",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: Container(
          child: Center(
            child: _loading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: filterDoctors.length,
                    itemBuilder: (context, index) {
                      // ListOfDoctors parser=userData[index];
                      final doc = filterDoctors[index];
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

                      return index == 0
                          ? _searchBar()
                          : Padding(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 4),
                                                    child: Text(
                                                      name,
                                                      // parser.email,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child: Text(
                                                                '${'Exp: '}${doc.experience}${' yrs'}',
                                                                // parser.email,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey),
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
                                                    // Align(
                                                    //   alignment: Alignment.topRight,
                                                    //   child: Padding(
                                                    //       padding:
                                                    //           const EdgeInsets.only(
                                                    //               left: 8, right: 8),
                                                    //       child: Icon(
                                                    //         Icons.videocam,
                                                    //         color: kPrimaryColor,
                                                    //       )),
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
        ));
  }
  // ListView(
  // shrinkWrap: true,
  // children: [
  // _searchBar(),
// _getDocId2() async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var docID2 = prefs.getString('docID');
//   print("doc id 2 from get method:-> $docID2");
// }

  // Shimmer.fromColors(
  // direction: ShimmerDirection.rtl,
  // period: Duration(seconds: 5),
  // child: Column(
  // children: [0, 1, 2, 3]
  //     .map((_) => Padding(
  // padding: const EdgeInsets.all(16),
  // child: Row(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Container(
  // width: 48.0,
  // height: 48.0,
  // color: Colors.white,
  // ),
  // Padding(
  // padding: const EdgeInsets.symmetric(
  // horizontal: 8.0),
  // ),
  // Expanded(
  // child: Column(
  // crossAxisAlignment:
  // CrossAxisAlignment.start,
  // children: [
  // Container(
  // width: double.infinity,
  // height: 8.0,
  // color: Colors.white,
  // ),
  // Padding(
  // padding: const EdgeInsets.symmetric(
  // vertical: 2.0),
  // ),
  // Container(
  // width: double.infinity,
  // height: 8.0,
  // color: Colors.white,
  // ),
  // Padding(
  // padding: const EdgeInsets.symmetric(
  // vertical: 2.0),
  // ),
  // Container(
  // width: 40.0,
  // height: 8.0,
  // color: Colors.white,
  // ),
  // ],
  // ),
  // )
  // ],
  // ),
  // ))
  //     .toList(),
  // ),
  // baseColor: Colors.grey[400],
  // highlightColor: Colors.grey[100])
}
