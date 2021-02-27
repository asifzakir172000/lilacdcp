import 'package:flutter/material.dart';
import 'package:lilacdcp/apiwork/models/ProfileData.dart';
import 'package:lilacdcp/uti/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lilacdcp/uti/constants.dart';
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  List gender = ["Male", "Female", "Other"];

  String select;

  List<ProfileModel> profiles;
  bool _loading = true;

  // _setValue() {

  // }

  Future<List<ProfileModel>> getDoctorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datatoken = prefs.getString('token');
    print(datatoken);

    final String url = "http://65.1.45.74:8181/user/getPatientProfile";
    var response = await http.post(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "token": datatoken});

    print(response.body);
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

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    );
  }

  void _setValue(ProfileModel doc) {
  nameController.text = "${doc.name.firstName}";
  lastNameController.text = "${doc.name.lastName}";
  emailController.text = "${doc.email}";
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
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final doc = profiles[index];
                  _setValue(doc);
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //image
                        Center(
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/doc_image2.webp'),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // First Name
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("First Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Enter First Name',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // Last Name
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("Last Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Enter Last Name',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // Email
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter Email',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // gender

                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("Gender",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        Row(
                          children: [
                            addRadioButton(0, 'Male'),
                            addRadioButton(1, 'Female'),
                            addRadioButton(2, 'Others'),
                          ],
                        ),

                        // Contact Number
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("Contact Number",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: contactController,
                          decoration: InputDecoration(
                            labelText: 'Enter Contact Number',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // City
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("City",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            labelText: 'Enter City',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // State
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          alignment: Alignment.topLeft,
                          child: Text("State",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),

                        TextFormField(
                          controller: stateController,
                          decoration: InputDecoration(
                            labelText: 'Enter State',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Color(0xFF8e539c),
                            // )
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          // controller: idController,
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        //button
                        Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {},
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
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 350.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
