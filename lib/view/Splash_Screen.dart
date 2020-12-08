import 'dart:async';

import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:flutter/material.dart';

class SplashScren extends StatefulWidget {
  SplashScren({Key key}) : super(key: key);

  @override
  _SplashScrenState createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => PatientDashBoard())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
