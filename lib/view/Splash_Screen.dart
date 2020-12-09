import 'dart:async';

import 'package:doctor_app/view/auth/Login_Screen.dart';
import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: Center(
          child: Text("Patient Care",
              style: GoogleFonts.aclonica(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28)),
        ),
      ),
    );
  }
}
