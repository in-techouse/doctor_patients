import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocBloodDonation.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  HelloDocBloodDonation donation = new HelloDocBloodDonation();
  String bloodGroup = "";
  String city = "";

  List<String> bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  List<String> cities = [
    "Lahore",
    "Islamabad",
    "Gujranwala",
    "Faisalabad",
    "Rawalpindi",
    "Kasur",
    "Gujrat",
    "Sialkot"
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    HelloDocUser user = HelloDocUser.getUserObject(preferences);
    donation.ownerId = user.id;
    setState(() {
      currentUser = user;
    });
  }

  void saveNewBloodDonation(startLoading, stopLoading, btnState) {
    FocusScope.of(context).requestFocus(FocusNode());
    Director.isConnected().then((value) {
      if (value) {
        if (bloodDonationFormKey.currentState.validate()) {
          startLoading();
          donation.id = reference.push().key;
          print("Blood Donation, Name: ${donation.name}");
          print("Blood Donation, Phone Number: ${donation.phoneNumber}");
          print("Blood Donation, City: ${donation.city}");
          print("Blood Donation, Blood Group: ${donation.bloodGroup}");
          print("Blood Donation, Id: ${donation.id}");
          print("Blood Donation, Owner Id: ${donation.ownerId}");
          reference.child(donation.id).set({
            Constants.ID: donation.id,
            Constants.OWNER_ID: donation.id,
            Constants.NAME: donation.name,
            Constants.PHONE: donation.phoneNumber,
            Constants.CITY: donation.city,
            Constants.BLOOD_GROUP: donation.bloodGroup,
          }).then((value) {
            stopLoading();
            Director.showSuccessWithClose(
                context, Constants.BLOOD_DONATION_POSTED);
          }).catchError((onError) {
            stopLoading();
            Director.showError(context, Constants.SMW_ERROR);
          });
        }
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name is required";
                            }
                            if (value.length < 3) {
                              return 'Name is invalid';
                            }
                            donation.name = value.trim();
                            return null;
                          },
                          decoration: new InputDecoration(
                              hintText: "Name",
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.grey)))),
                      SizedBox(height: 11),
                      TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Phone number is required";
                            }
                            if (value.length != 11) {
                              return 'Phone number is invalid';
                            }
                            donation.phoneNumber = value.trim();
                            return null;
                          },
                          decoration: new InputDecoration(
                              hintText: "Phone number",
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.grey)))),
                      SizedBox(height: 11),
                      DropdownButtonFormField(
                        hint: Text('Choose Blood Group'),
                        isDense: true,
                        onChanged: (newValue) {
                          donation.bloodGroup = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.length < 1) {
                            return "Select valid Blood Group";
                          }
                          return null;
                        },
                        items: bloodGroups.map((bloodGroup) {
                          return DropdownMenuItem(
                            child: new Text(bloodGroup),
                            value: bloodGroup,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 11),
                      DropdownButtonFormField(
                        hint: Text('Choose City'),
                        isDense: true,
                        onChanged: (newValue) {
                          donation.city = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.length < 1) {
                            return "Select valid City";
                          }
                          return null;
                        },
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            child: new Text(city),
                            value: city,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
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
