import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/RegistrationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/LoginScreen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String email = '';

  Future getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email=prefs.getString('email');
  }

  @override
  void initState() {
    super.initState();
    _tabController=TabController(initialIndex: 0,length: 2,vsync: this);
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Lilac Dcp',style: TextStyle(color: Colors.white,fontSize: 16),),
        leading: Image.asset('assets/applogolilac.png',height: 20,width: 20,),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text('Login',style: TextStyle(color: Colors.white),),
            ),
            Tab(
              child: Text('Register',style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LoginScreen(),
          Register()
        ],
      ),
    );
  }
}
