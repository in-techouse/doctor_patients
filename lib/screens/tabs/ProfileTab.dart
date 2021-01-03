import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/screens/auth/LoginScreen.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child(Constants.USERS);
  bool isEditing = false;
  HelloDocUser user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    HelloDocUser u = HelloDocUser.getUserObject(preferences);
    setState(() {
      user = u;
    });
  }

  void enableEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void disableEditing() {
    setState(() {
      isEditing = false;
    });
  }

  void updateProfile(startLoading, stopLoading, btnState) {
    print("Update Profile Clicked");
    Director.isConnected().then((value) async {
      if (value) {
        if (editFormKey.currentState.validate()) {
          startLoading();
          await Future.delayed(Duration(seconds: 2));
          reference.child(user.id).set({
            Constants.ID: user.id,
            Constants.ROLE: user.role,
            Constants.NAME: user.name,
            Constants.PHONE: user.phone,
            Constants.EMAIL: user.email,
          }).then((value) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(Constants.ID, user.id);
            prefs.setInt(Constants.ROLE, user.role);
            prefs.setString(Constants.NAME, user.name);
            prefs.setString(Constants.EMAIL, user.email);
            prefs.setString(Constants.PHONE, user.phone);
            stopLoading();
            setState(() {
              isEditing = false;
            });
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

  void logoutUser(startLoading, stopLoading, btnState) async {
    startLoading();
    if (auth.currentUser != null) {
      auth.signOut();
    }
    HelloDocUser.deleteSession();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
    Director.popUntilRoot(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (user == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitHourGlass(
            color: HelloDocColors.colorPrimary,
          ),
          SizedBox(height: 15),
          Text("Please wait...!",
              style:
                  TextStyle(color: HelloDocColors.colorPrimary, fontSize: 17)),
        ],
      );
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 40, 8.0, 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width,
                      child: Text("HelloDoc24",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aclonica(
                              color: HelloDocColors.colorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 23)),
                    ),
                    SizedBox(height: height * 0.02),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(11, 20, 11, 20),
                        child: Form(
                          key: editFormKey,
                          child: Column(
                            children: [
                              isEditing == false
                                  ? GestureDetector(
                                      onTap: enableEditing,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "EDIT PROFILE",
                                            style: TextStyle(
                                                color: HelloDocColors
                                                    .colorPrimary),
                                          ),
                                          Icon(
                                            Icons.edit,
                                            color: HelloDocColors.colorPrimary,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: disableEditing,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "CLOSE",
                                            style: TextStyle(
                                                color:
                                                    HelloDocColors.colorDanger),
                                          ),
                                          Icon(
                                            Icons.close,
                                            color: HelloDocColors.colorDanger,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ),
                              TextFormField(
                                  initialValue: user.name,
                                  readOnly: !isEditing,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Name is required';
                                    }
                                    if (value.length < 3) {
                                      return "Name is invalid";
                                    }
                                    user.name = value.trim();
                                    return null;
                                  },
                                  decoration: new InputDecoration(
                                      hintText: "Name",
                                      prefixIcon: Icon(Icons.person),
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey)))),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  initialValue: user.phone,
                                  readOnly: !isEditing,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    if (value.length != 11) {
                                      return "Phone Number is invalid";
                                    }
                                    user.phone = value.trim();
                                    return null;
                                  },
                                  decoration: new InputDecoration(
                                      hintText: "Phone Number",
                                      prefixIcon: Icon(Icons.phone),
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey)))),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  initialValue: user.email,
                                  readOnly: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: new InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.email_outlined),
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey)))),
                              SizedBox(
                                height: 15,
                              ),
                              isEditing
                                  ? ArgonButton(
                                      height: 55,
                                      roundLoadingShape: true,
                                      width: width,
                                      onTap: updateProfile,
                                      child: Text(
                                        "UPDATE",
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
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: ArgonButton(
                        height: 60,
                        roundLoadingShape: true,
                        width: width,
                        onTap: logoutUser,
                        child: Text(
                          "LOGOUT",
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
                        color: HelloDocColors.colorDanger,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
