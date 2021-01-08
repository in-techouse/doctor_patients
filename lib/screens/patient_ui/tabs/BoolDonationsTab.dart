import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllBloodDonations();
  }

  void loadAllBloodDonations() {
    reference
      ..once().then((data) {
        print('Data ${data.toString()}');
        Map<dynamic, dynamic> list = data.value;
        // List<HelloDocUser> temp = new List<HelloDocUser>();
        // if (list != null) {
        //   list.forEach((value, v1) {
        //     print("Value: ${value.toString()}");
        //     if (v1 != null) {
        //       print("Value: ${v1.toString()}");
        //       try {
        //         HelloDocUser user = HelloDocUser.fromJSON(v1);
        //         print("?User Role is: ${user.role}");
        //         temp.add(user);
        //       } catch (e) {
        //         print('Exception: ${e.toString()}');
        //       }
        //     }
        //   });
        //   print('Data Snapshot ${data.value}');
        // }
        // setState(() {
        //   doctors = temp;
        //   isLoading = false;
        // });
      }).catchError((var error) {
        setState(() {
          isLoading = false;
        });
        Director.showError(context, Constants.SMW_ERROR);
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
    return Container();
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
