import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewBloodDonation extends StatefulWidget {
  @override
  _NewBloodDonationState createState() => _NewBloodDonationState();
}

class _NewBloodDonationState extends State<NewBloodDonation> {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child(Constants.TABLE_BLOOD_DONATIONS);
  GlobalKey<FormState> bloodDonationFormKey = GlobalKey<FormState>();
  HelloDocUser currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    HelloDocUser user = HelloDocUser.getUserObject(preferences);
    setState(() {
      currentUser = user;
    });
  }

  void saveNewBloodDonation(startLoading, stopLoading, btnState) {
    FocusScope.of(context).requestFocus(FocusNode());
    Director.isConnected().then((value) {
      if (value && bloodDonationFormKey.currentState.validate()) {
      } else {
        Director.showError(context, Constants.NO_INTERNET);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("NEW BLOOD DONATION"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: HelloDocColors.colorPrimary,
      ),
      body: Container(
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: bloodDonationFormKey,
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ArgonButton(
            height: 65,
            roundLoadingShape: true,
            width: width,
            onTap: saveNewBloodDonation,
            child: Text(
              "POST",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            loader: Container(
              padding: EdgeInsets.all(10),
              child: SpinKitHourGlass(
                color: Colors.white,
                // size: loaderWidth ,
              ),
            ),
            borderRadius: width * 0.4,
            color: HelloDocColors.colorPrimary,
          ),
        ),
      ),
    );
  }
}
