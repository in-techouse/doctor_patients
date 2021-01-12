import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/model/HelloDocBloodDonation.dart';
import 'package:doctor_app/screens/patient_ui/NewBloodDonation.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BloodDonationsTab extends StatefulWidget {
  @override
  _BloodDonationsTabState createState() => _BloodDonationsTabState();
}

class _BloodDonationsTabState extends State<BloodDonationsTab> {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child(Constants.TABLE_BLOOD_DONATIONS);
  List<HelloDocBloodDonation> bloodDonations =
      List<HelloDocBloodDonation>.empty(growable: true);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllBloodDonations();
  }

  void loadAllBloodDonations() {
    reference.onValue.listen((event) {
      print("Event: ${event.toString()}");
      print("Event Snapshot: ${event.snapshot.toString()}");
      print("Event Snapshot Value: ${event.snapshot.value.toString()}");
      setState(() {
        isLoading = true;
        bloodDonations = List<HelloDocBloodDonation>.empty(growable: true);
      });
      List<HelloDocBloodDonation> temp =
          List<HelloDocBloodDonation>.empty(growable: true);
      if (event != null &&
          event.snapshot != null &&
          event.snapshot.value != null) {
        Map<dynamic, dynamic> list = event.snapshot.value;
        list.forEach((key, value) {
          if (value != null) {
            try {
              HelloDocBloodDonation bloodDonation =
                  HelloDocBloodDonation.fromJSON(value);
              if (bloodDonation != null) {
                print("Blood Donation is: ${bloodDonation.name}");
                temp.add(bloodDonation);
              }
            } catch (e) {
              print('Exception: ${e.toString()}');
            }
          }
        });
      }
      setState(() {
        bloodDonations = temp;
        isLoading = false;
      });
    });
  }

  Widget showLoadingBar() {
    return Center(
      child: SpinKitHourGlass(
        color: HelloDocColors.colorPrimary,
      ),
    );
  }

  Widget showAllBloodDonations() {
    return ListView.builder(
      itemCount: bloodDonations.length,
      itemBuilder: (context, index) {
        final bloodDonation = bloodDonations[index];
        return Padding(
          padding: const EdgeInsets.all(11.0),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 11,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bloodDonation.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: HelloDocColors.colorPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "BLOOD GROUP",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bloodDonation.bloodGroup,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary, fontSize: 17),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CITY",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bloodDonation.city,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary, fontSize: 17),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CONTACT",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bloodDonation.phoneNumber,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: HelloDocColors.colorPrimary, fontSize: 17),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void newBloodDonation() {
    print("Move to new Blood Donation");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewBloodDonation()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == true ? showLoadingBar() : showAllBloodDonations(),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: HelloDocColors.colorPrimary,
            onPressed: newBloodDonation));
  }
}
