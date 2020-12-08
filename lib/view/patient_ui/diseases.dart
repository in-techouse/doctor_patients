import 'package:doctor_app/view/utilis/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DiseasesCard(txt: 'Cold Flu',),
              DiseasesCard(txt: 'Allergies',),
              DiseasesCard(txt: 'Cardio Vascular',),
              DiseasesCard(txt: 'HairFall',),
              DiseasesCard(txt: 'Diabetics',),
              DiseasesCard(txt: 'Headache',),
              DiseasesCard(txt: 'Stomachache',),

            ],
          ),
        ),
      ),
    );
  }
}

class DiseasesCard extends StatelessWidget {
  String txt;
  DiseasesCard({this.txt});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;
    return Card(
      child: Container(
        width: width,
          height: 50,
          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
          child: Text(txt)),
    );
  }
}
