import 'package:doctor_app/view/utilis/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class PatientDashBoard extends StatefulWidget {
  PatientDashBoard({Key key}) : super(key: key);

  @override
  _PatientDashBoardState createState() => _PatientDashBoardState();
}

class _PatientDashBoardState extends State<PatientDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: SafeArea(

      ),
    );
  }
}
