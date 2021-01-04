import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Treatments.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrescriptionScreen extends StatefulWidget {
  PrescriptionScreen({this.disease});

  String disease = "";

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  var prescriptions;

  @override
  void initState() {
    super.initState();
    print("PrescriptionScreen, Disease is: ${widget.disease}");

    if (widget.disease == Constants.COLD_FLU) {
      setState(() {
        prescriptions = Treatments.COLD_FLU;
      });
    } else if (widget.disease == Constants.ALLERGIES) {
      setState(() {
        prescriptions = Treatments.ALLERGIES;
      });
    } else if (widget.disease == Constants.CARDIO_VASCULAR) {
      setState(() {
        prescriptions = Treatments.CARDIO_VASCULAR;
      });
    } else if (widget.disease == Constants.HAIR_FALL) {
      setState(() {
        prescriptions = Treatments.HAIR_FALL;
      });
    } else if (widget.disease == Constants.DIABETES) {
      setState(() {
        prescriptions = Treatments.DIABETICS;
      });
    } else if (widget.disease == Constants.HEADACHE) {
      setState(() {
        prescriptions = Treatments.HEADACHE;
      });
    } else if (widget.disease == Constants.STOMACHACHE) {
      setState(() {
        prescriptions = Treatments.STOMACHACHE;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRESCRIPTION SCREEN"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: HelloDocColors.colorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
                color: HelloDocColors.colorPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Center(
                      child: Text(
                    'Your prescription for ${widget.disease} is',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: HelloDocColors.colorWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                )),
            prescriptions.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: prescriptions.length,
                                  itemBuilder: (context, index) {
                                    final precaution = prescriptions[index];
                                    final treatment = precaution["treatment"];
                                    final subTreatments =
                                        precaution["subTreatment"];
                                    print(
                                        "PrescriptionScreen, subTreatment is ${subTreatments.toString()}");
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${(index + 1)}. $treatment",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color:
                                                    HelloDocColors.colorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          for (var i in subTreatments)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 21, right: 21),
                                              child: Text(
                                                i.toString(),
                                                textAlign: TextAlign.start,
                                              ),
                                            )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
