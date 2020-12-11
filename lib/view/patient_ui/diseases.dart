import 'package:doctor_app/view/patient_ui/diseaseQuestions.dart';
import 'package:doctor_app/view/utilis/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double l = MediaQuery
        .of(context)
        .size
        .longestSide;
    Orientation orien = MediaQuery
        .of(context)
        .orientation;
    bool screen = orien == Orientation.portrait ? true : false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        DiseaseQuestions(disease: 'Cold Flu',)));
              }, child: DiseasesCard(txt: 'Cold Flu',)),
              GestureDetector(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        DiseaseQuestions(disease: 'Allergies',)));
              }, child: DiseasesCard(txt: 'Allergies',)),
              GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DiseaseQuestions(disease: 'Cardio Vascular',)));
              }, child: DiseasesCard(txt: 'Cardio Vascular',)),
              GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DiseaseQuestions(disease: 'HairFall',)));
              }, child: DiseasesCard(txt: 'HairFall',)),
              GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DiseaseQuestions(disease: 'Diabetics',)));
              }, child: DiseasesCard(txt: 'Diabetics',)),
              GestureDetector(onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DiseaseQuestions(disease: 'Headache',)));
              },child:  DiseasesCard(txt: 'Headache',)),
              GestureDetector(onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DiseaseQuestions(disease: 'Stomachache',)));
              },child: DiseasesCard(txt: 'Stomachache',)),

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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double l = MediaQuery
        .of(context)
        .size
        .longestSide;
    Orientation orien = MediaQuery
        .of(context)
        .orientation;
    bool screen = orien == Orientation.portrait ? true : false;
    return Card(
      child: Container(
          width: width,
          height: 50,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: GestureDetector(child: Text(txt))),
    );
  }
}
