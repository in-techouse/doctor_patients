import 'package:doctor_app/screens/patient_ui/tabs/DiseasesListTab.dart';
import 'package:doctor_app/screens/tabs/ProfileTab.dart';
import 'package:flutter/material.dart';

class PatientDashBoard extends StatefulWidget {
  @override
  _PatientDashBoardState createState() => _PatientDashBoardState();
}

class _PatientDashBoardState extends State<PatientDashBoard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.message)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: Text('USER DASHBOARD'),
          centerTitle: true,
          elevation: 11.0,
        ),
        body: TabBarView(
          children: [
            DiseasesListTab(),
            Icon(Icons.directions_transit),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}