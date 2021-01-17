import 'package:doctor_app/screens/patient_ui/tabs/DiseasesListTab.dart';
import 'package:doctor_app/screens/tabs/ChatsTab.dart';
import 'package:doctor_app/screens/tabs/ProfileTab.dart';
import 'package:flutter/material.dart';

import '../tabs/BoolDonationsTab.dart';

class PatientDashBoard extends StatefulWidget {
  @override
  _PatientDashBoardState createState() => _PatientDashBoardState();
}

class _PatientDashBoardState extends State<PatientDashBoard> {
  @override
  Widget build(BuildContext context) {
    // Tab(icon: Icon(Icons.adb_sharp)),
    // Tab(icon: Icon(Icons.whatshot_sharp)),

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: new Image.asset("assets/images/disease.png")),
              Tab(icon: new Image.asset("assets/images/blood.png")),
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
            BloodDonationsTab(),
            ChatsTab(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
