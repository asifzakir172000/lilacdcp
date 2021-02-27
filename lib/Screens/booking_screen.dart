import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/PastAppoinmentScreen.dart';
import 'package:lilacdcp/Screens/UpcomingAppoinmentScreen.dart';

import 'package:lilacdcp/uti/constants.dart';

class AppBookingScreen extends StatefulWidget {
  @override
  _AppBookingScreenState createState() => _AppBookingScreenState();
}

class _AppBookingScreenState extends State<AppBookingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isExtended = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TabBar(
          indicatorColor: kPrimaryColor,
          controller: _tabController,
          // unselectedLabelColor: kPrimaryColor,
          // indicatorSize: TabBarIndicatorSize.label,
          // indicator:  color: kPrimaryColor,
          tabs: [
            Tab(
              child: Text(
                'Upcoming Booking',
                style: TextStyle(color: kPrimaryColor, fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                'Past Booking',
                style: TextStyle(color: kPrimaryColor, fontSize: 14),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TabBarView(
          controller: _tabController,
          children: [UpcomingAppoint(),PastAppoint()],
        ),
      ),
    );
  }
}
