import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/screens/patient_ui/DiseaseQuestions.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:flutter/material.dart';

class DiseasesListTab extends StatefulWidget {
  @override
  _DiseasesListTabState createState() => _DiseasesListTabState();
}

class _DiseasesListTabState extends State<DiseasesListTab> {
  List<String> diseases = Constants.DISEASES;

  void openDiseaseQuestions(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DiseaseQuestions(
                  index: index,
                )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Card(
              color: HelloDocColors.colorPrimary,
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: Center(
                    child: Text(
                  'Select the disease, about which you want to take precautions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HelloDocColors.colorWhite,
                    fontSize: 17,
                  ),
                )),
              )),
          Flexible(
            child: SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: diseases.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(7),
                      child: GestureDetector(
                          onTap: () {
                            openDiseaseQuestions(index);
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 13,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Center(
                                    child: Text(
                                  '${diseases[index]}',
                                  style: TextStyle(
                                      color: HelloDocColors.colorPrimary,
                                      fontSize: 20),
                                )),
                              ))),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
