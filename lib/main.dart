import 'package:flutter/material.dart';
import 'package:lilacdcp/Screens/AppiontmentsScreen.dart';
import 'package:lilacdcp/Screens/LoginScreen.dart';
import 'package:lilacdcp/Screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyVideoCall(),
      home: LoginScreen(),
      routes: {
        '/p': (context) => ProfileScreen(),
        '/d': (context) => AppointmentScreen(),
      },
      )
      );
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lilac Dcp',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }

// }



