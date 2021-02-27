import 'package:flutter/material.dart';
import 'package:lilacdcp/uti/constants.dart';

class PastBookingScreen extends StatefulWidget {
  @override
  _PastBookingScreenState createState() => _PastBookingScreenState();
}

class _PastBookingScreenState extends State<PastBookingScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
                elevation: 1.0,
                child: InkWell(
                  onTap: () {
                    print('printing on past appoinment:->');
                  },
                  child:
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child:
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/doc_image2.webp'),
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
                                      fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,),
                                )),
                            Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  '25-02-2021',
                                  // parser.email,
                                  style: TextStyle(
                                    fontSize: 14,color: Colors.grey),
                                )),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      '11:00 AM',
                                      // parser.email,
                                      style: TextStyle(
                                          fontSize: 14,color: Colors.grey),
                                    )),
                                Container(color: Colors.grey, height: 15, width: 1,),
                                Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      '11:30 AM',
                                      // parser.email,
                                      style: TextStyle(
                                          fontSize: 14,color: Colors.grey),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8),
                          child:
                          FlatButton(
                            onPressed: (){},
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            child: Text('Complete',style: TextStyle(color: Colors.white),),
                          ))
                    ],

                  ),
                ),
              ),
            );
          }),
    );
  }
}
