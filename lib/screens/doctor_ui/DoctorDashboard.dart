import 'package:doctor_app/screens/tabs/ProfileTab.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: Text('DOCTOR DASHBOARD'),
          centerTitle: true,
          elevation: 11.0,
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
