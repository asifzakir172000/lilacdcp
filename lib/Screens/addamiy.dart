import 'package:flutter/material.dart';
import 'package:lilacdcp/uti/constants.dart';

class AddFamily extends StatefulWidget {
  @override
  _AddFamilyState createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  // List<Map> data = [
  //   {
  //     'name': 'Family Member 1, FeMale, 25',
  //     'phone': '0000000000',
  //     'email': 'email.com',
  //     'relationship': 'Father'
  //   },
  //   {
  //     'name': 'Family Member 1, FeMale, 25',
  //     'phone': '0000000000',
  //     'email': 'email.com',
  //     'relationship': 'Father'
  //   }
  // ];

  List data = [
    'Family Member 1, Male, 25',
    'Family Member 1, FeMale, 25',
  ];

  @override
  Widget build(BuildContext context) {
    bool rememberMe = true;
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
          "Add Family Member",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
        color: Colors.white,
        child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black)
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                            child: Text(
                              data[index],
                              // parser.email,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                            child: Text(
                              '+91 0000000000',
                              // parser.email,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,),
                            ),
                          ),
                          Container(
                  alignment: Alignment.topLeft,
                            child: Text(
                              'e.g@gmai.com',
                              // parser.email,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,),
                            ),
                          ),
                          Container(
                  alignment: Alignment.topLeft,
                            child: Text(
                              'son',
                              // parser.email,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      
                      //Checkbox
                      Container(
                        margin: EdgeInsets.only(right: 30),
                          child: Checkbox(
                            value: rememberMe,
                        onChanged: (bool value) {
                          setState(() {
                            rememberMe = value;
                            print(rememberMe.toString());
                          });
                        },
                      ))
                    ],
                  ));
            }),
      ),
    );
  }
}
