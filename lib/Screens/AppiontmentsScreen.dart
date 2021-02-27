
import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/booking_screen.dart';
import 'package:lilacdcp/Screens/DoctorListScreen.dart';
import 'package:lilacdcp/Screens/Home.dart';
import 'package:lilacdcp/Screens/profile.dart';
import 'package:lilacdcp/Screens/profilevieewdata.dart';
import 'package:lilacdcp/uti/constants.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int curentState = 0;
  List<Widget> widgets = [HomeScreen(), DoctorListScreen(), AppBookingScreen(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        currentIndex:curentState,

        type: BottomNavigationBarType.fixed,
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: kPrimaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            // FontAwesomeIcons.user-md
            icon: Icon(Icons.calendar_today,),
            title: Text('Doctor'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book,),
            title: Text('My Bookings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                // color: kPrimaryColor
            ),
            title: Text('Profile'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   title: Text('Profile'),
          // ),
        ],
        onTap: (int index){
          setState(() {
            curentState=index;
          });
        },
      ),
    
        body: widgets[curentState],
      );
  }
}
