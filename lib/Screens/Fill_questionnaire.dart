import 'package:flutter/material.dart';
import 'package:lilacdcp/uti/constants.dart';


class FillQuestionnaire extends StatefulWidget {
  @override
  _FillQuestionnaireState createState() => _FillQuestionnaireState();
}

class _FillQuestionnaireState extends State<FillQuestionnaire> {


List gender = ["Yes", "NO"];

  String select;

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
          // style: TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    );
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
          "Fill Questionnaire",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: [
              //q.1
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Text("Q.1. Aiolos Transform Amen,Aiolos Transform Amen, Aiolos Transform Amen, Aiolos Transform Amen, Aiolos Transform Amen.")),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  maxLines: null,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      hintStyle: TextStyle(
                          color: Colors.black, fontFamily: "WorkSansLight"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
              ),

              //q.2

Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Q2. Smoking"),
                    Row(
                      children: [
                        addRadioButton(0, 'Yes'),
                        addRadioButton(1, 'No'),
                      ],
                    )
                  ],
                ),
                ),
              
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  maxLines: null,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      hintStyle: TextStyle(
                          color: Colors.black, fontFamily: "WorkSansLight"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
              ),



              //q.3
               Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Text("Q.3. Aiolos Transform Amen,Aiolos Transform Amen, Aiolos Transform Amen, Aiolos Transform Amen, Aiolos Transform Amen.")),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  textAlign: TextAlign.justify,
                  maxLines: null,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      hintStyle: TextStyle(
                          color: Colors.black, fontFamily: "WorkSansLight"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
              ),

              SizedBox(
                height: 30,
              ),
            
            //  button
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
                      constraints:
                          BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

            ],
          ),
        ),
      ),
    );
  }
}