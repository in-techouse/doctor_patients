import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/screens/auth/LoginScreen.dart';
import 'package:doctor_app/screens/doctor_ui/DoctorDashboard.dart';
import 'package:doctor_app/screens/patient_ui/PatientDashboard.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class HelloDocSplashScreen extends StatefulWidget {
  @override
  _HelloDocSplashScreenState createState() => _HelloDocSplashScreenState();
}

class _HelloDocSplashScreenState extends State<HelloDocSplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<HelloDocUser> getCurrentUser() async {
    if (auth.currentUser == null) {
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return HelloDocUser.getUserObject(prefs);
  }

  Widget sendRelevantScreen() {
    return FutureBuilder<HelloDocUser>(
      future: getCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<HelloDocUser> u) {
        if (u != null && u.data != null) {
          if (u.data.role == 0) {
            return DoctorDashboard();
          } else {
            return PatientDashBoard();
          }
        }
        return LoginScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: sendRelevantScreen(),
      title: new Text(''),
      image: Image.asset("assets/images/logo.jpeg"),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      loaderColor: HelloDocColors.colorPrimary,
    );
  }
}
