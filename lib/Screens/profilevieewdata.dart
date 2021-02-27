import 'package:flutter/material.dart';
import 'package:lilacdcp/apiwork/models/ProfileData.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProfileScreenData2 extends StatefulWidget {
  @override
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ProfileScreenData2> {
  // final String url = "http://65.1.45.74:8181/doctor/get-all";
  List userData;
  bool _loading = true;
  String email = "";

  List _profileLables=['First Name','Last Name','Mail','Speciality','Contact Number','Qualification','Experience'];
  List<ProfileModel> profiles;

  Future<List<ProfileModel>> getDoctorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final String url = "http://65.1.45.74:8181/user/getPatientProfile";
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});
    Map<String, dynamic> respMapDoc = json.decode(response.body);
    setState(() {
      profiles = (respMapDoc['data'] as List)
          .map((e) => ProfileModel.fromJson(e))
          .toList();
      print("List converted Data:-> ${profiles.join("<>")}");
      _loading = false;
    });

    return profiles;
  }


  @override
  void initState() {
    super.initState();
    this.getDoctorData();
  }

  String docID = '';
  TextStyle getTextStyle() {
    return const TextStyle(
        fontSize: 16,
        fontFamily: 'poppins_regular',
        color: Colors.black);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Doctor List",
              style: TextStyle(fontFamily: 'poppins_regular', fontSize: 15)),
        ),
        body:
        Container(
          child:  Center(
            child:_loading ? CircularProgressIndicator() :
            ListView.builder(itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final doc = profiles[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                        elevation: 1.0,
                        child: InkWell(
                          onTap: () {},
                          child: Stack(
                              children:[ Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child:
                                        ListTile(
                                          leading: Text("first name:", style: getTextStyle()),
                                          title:Text(doc.name.firstName,
                                            // parser.email,
                                            style: getTextStyle(),
                                          ) ,
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child:
                                        ListTile(
                                          leading: Text("Last name:", style: getTextStyle()),
                                          title:Text(doc.name.lastName, style: getTextStyle(),
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ListTile(
                                          leading: Text("Mail:", style: getTextStyle()),
                                          title:Text(doc.email, style: getTextStyle(),
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ListTile(
                                          leading: Text("user_type:", style: getTextStyle()),
                                          title:Text(doc.userType, style: getTextStyle(),
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ListTile(
                                          leading: Text("Contact Number:", style: getTextStyle()),
                                          title:Text(doc.password, style: getTextStyle(),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              ]
                          ),
                        )),
                  );
                }),

          ),

        ));
  }
}
