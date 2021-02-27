import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lilacdcp/Screens/AppiontmentsScreen.dart';
import 'package:lilacdcp/Screens/RegistrationScreen.dart';
import 'package:lilacdcp/apiwork/api_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lilacdcp/uti/constants.dart';

import 'DoctorListScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  var message = '';

  @override
  dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
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
                              padding:
                                  const EdgeInsets.fromLTRB(0, 30, 0.0, 0.0),
                              child: Text(
                                'Lilac DCP',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'poppins_regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // Text(
                      //   'Login',
                      //   style: TextStyle(
                      //       fontSize: 25, fontFamily: 'poppins_regular'),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter UserId',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            prefixIcon: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        controller: idController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Enter Password',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansLight"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            filled: true,
                            fillColor: Colors.white24,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        _loginToEnterApp();
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
                          constraints:
                              BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                      // MaterialButton(
                      //   onPressed: () async {
                      //     _loginToEnterApp();
                      //   },
                      //   child: Text('Login',
                      //       style: TextStyle(
                      //           fontFamily: 'poppins_regular',
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 15)),
                      //   textColor: Colors.white,
                      //   color: Color(0xFF8e539c),
                      //   elevation: 0,
                      //   minWidth: double.infinity,
                      //   height: 50,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(90)),
                      // ),

                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Register();
                              },
                            ),
                          );
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontFamily: 'poppins_regular',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    fontFamily: 'poppins_regular',
                                    color: Theme.of(context).accentColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }

  _loginToEnterApp() async {
    if (_formKey.currentState.validate()) {
      var email = idController.text;
      var password = passwordController.text;

      //printing in logcat
      print("UserID: ${email} Password:${password}");

      //api calls
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var rsp = await loginUser(email, password, prefs.getString('Data'));
      print(rsp);
      if (rsp.containsKey('status')) {
        setState(() {
          message = rsp['message'];
        });
        if (rsp['status'] == 'success') {
          // UserPreferences().saveUser(rsp);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', 'email');
          prefs.setString('data', 'data');
          final email = prefs.getString('email');
          final data = prefs.getString('token');
          print(email);
          print("TOKEN:-> $data");
          Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              // backgroundColor: Color(0xFF8e539c),
              textColor: Colors.white,
              fontSize: 15.0);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return AppointmentScreen();
          }));
        }
      } else {
        Fluttertoast.showToast(
            msg: "Login Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            // backgroundColor: Color(0xFF8e539c),
            textColor: Colors.white,
            fontSize: 15.0);
        setState(() {
          message = 'login failed';
        });
      }
    }
  }
}
