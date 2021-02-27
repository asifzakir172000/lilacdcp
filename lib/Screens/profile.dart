import 'package:flutter/material.dart';
import 'package:lilacdcp/apiwork/api_dart.dart';
import 'package:lilacdcp/apiwork/models/ProfileData.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:lilacdcp/Screens/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // List<ProfileData> _profileData;

  // Future<List<ProfileData>> getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var datatoken = prefs.getString('token');
  //   print('token from json:-> $datatoken');
  //   final String url = "http://65.1.45.74:8181/user/getPatientProfile";

  //   var response = await http.post(Uri.encodeFull(url),
  //       headers: {"Accept": "application/json", "token": datatoken});
  //   Map<String, dynamic> respMapDoc = json.decode(response.body);
  //   print(response.body);
  //   print(response);
  //   setState(() {
  //     _profileData = (respMapDoc['data'] as List)
  //         .map((e) => ProfileData.fromJson(e))
  //         .toList();
  //     print("List converted Data:-> ${_profileData.join("<>")}");
  //   });
  //   return _profileData;
  // }

 List<ProfileModel> profiles;
 bool _loading = true;

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
      
      _loading = false;
      print("List converted Data:-> ${profiles.join("<>")}");
    });

    return profiles;
  }


  @override
  void initState() {
    super.initState();
    this.getDoctorData();
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
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Center(
        child: _loading? CircularProgressIndicator() : ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index){
            final doc = profiles[index];
            return Container(
              child: Column(children: [
                Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/doc_image2.webp',
                          height: 150,
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
                                    "${doc.name.firstName}\n${doc.name.lastName}",
                                    // parser.email,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    '+91 0000000000',
                                    // parser.email,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfileScreen();
                }))
              },
              child: ListTile(
                title: Text('Edit profile',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black54,
                ),
                leading:
                    // SvgPicture.asset('assets/svgs/user (1).svg',height: 20,width: 20,),
                    Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('My Records',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
              ),
              leading: Icon(
                Icons.notifications_none_sharp,
                color: Colors.black54,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('Manage Family Members',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
              ),
              leading: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('Change Password',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
              ),
              leading: Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.black54,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('Terms And Conditions',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
              ),
              leading: Icon(
                Icons.rate_review_outlined,
                color: Colors.black54,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('Contact Us',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
              ),
              leading: Icon(
                Icons.rate_review_outlined,
                color: Colors.black54,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Divider(
                  color: Colors.black,
                )),
            ListTile(
              title: Text('Logout',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              leading: Icon(
                Icons.logout,
                color: Colors.black54,
              ),
            ),
          
              ],),
            );
          }
        ),
      )
    );
  }
}


