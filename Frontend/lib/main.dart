// import 'package:a2f_frontend/screens/loginscreen.dart';
// import 'package:a2f_frontend/screens/regscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Anim.dart';
import 'package:flutter_application_1/screens/Homepage.dart';
import 'package:flutter_application_1/screens/PendingWithdrawals.dart';
import 'package:flutter_application_1/screens/loginscreen.dart';

import 'Forms/RechargeFoRM.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amader A2F',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: anim());
  }
}
