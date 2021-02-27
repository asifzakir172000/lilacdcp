import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lilacdcp/Screens/AppiontmentsScreen.dart';
import 'package:lilacdcp/apiwork/api_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //declare key for getting validator and values
  final _key = GlobalKey<FormState>();

  //get values from textformfield
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userTypeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  //varables for saved.
  String name, email, password;

  var message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _key,
          // key: _key,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/applogolilac.png',
                          height: 90,
                          width: 90,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0.0, 0.0),
                          child: Text(
                            'Lilac DCP',
                            style: TextStyle(
                                fontSize: 30, fontFamily: 'poppins_regular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   'Register Here',
                  //   style: TextStyle(fontSize: 20,fontFamily: 'poppins_regular'),
                  // ),
                  SizedBox(
                    height: 30,
                  ),

                  //first name

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text("First Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter First Name',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: "WorkSansLight"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF8e539c),
                        )),
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  //last name
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text("Last Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter last Name',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: "WorkSansLight"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF8e539c),
                        )),
                    controller: lastNameController,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //Email
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text("Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Enter Email',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: "WorkSansLight"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF8e539c),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter email';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //password
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text("Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                       return 'enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'password',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: "WorkSansLight"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF8e539c),
                        )),
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  // cp
                  //password
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text("Conform Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Conform Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter Conform Password',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: "WorkSansLight"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF8e539c),
                        )),
                    controller: cpasswordController,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (passwordController.text.length > 5) {
                          if (cpasswordController.text ==
                              passwordController.text) {
                            _registerTOEnterApp();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password and Conform Password must be same.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color(0xFF8e539c),
                                textColor: Colors.white,
                                fontSize: 15.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Enter Password atleast 6 digit.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xFF8e539c),
                              textColor: Colors.white,
                              fontSize: 15.0);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF8e539c), Colors.purple[100]],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }

  _registerTOEnterApp() async {
    if (_key.currentState.validate()) {
      var first_name = nameController.text;
      var email = emailController.text;
      var password = passwordController.text;
      var user_type = "customer";
      var last_name = lastNameController.text;

      //printing in logcat
      print(
          "name:${first_name} lastname:${last_name} email: ${email} Password:${password} usertype: customer ");

      //api calls for register

      var rsp = await singUP(first_name, last_name, email, password, user_type);
      print(rsp['message']);

      if (rsp.containsKey('status')) {
        setState(() {
          message = rsp['message'];
        });
        if (rsp['status'] == 'success') {

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', 'email');
          prefs.setString('data', rsp['data']);
          final email = prefs.getString('email');
          final data = prefs.getString('token');
          print(email);
          print("TOKEN:-> $data");
          Fluttertoast.showToast(
              msg: "Register Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xFF8e539c),
              textColor: Colors.white,
              fontSize: 15.0);
              
              
Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AppointmentScreen()));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } else {
        Fluttertoast.showToast(
            msg: rsp['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 15.0);

        setState(() {
          message = 'Registration failed';
        });
      }
    }
  }
}
