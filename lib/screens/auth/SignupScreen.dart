import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/screens/doctor_ui/DoctorDashboard.dart';
import 'package:doctor_app/screens/patient_ui/PatientDashboard.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  HelloDocUser user = new HelloDocUser();
  String valuePassword, valuePasswordConfirmation;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child(Constants.USERS);

  @override
  void initState() {
    super.initState();
    user.role = 0;
  }

  void registerUser(startLoading, stopLoading) {
    FocusScope.of(context).requestFocus(FocusNode());
    Director.isConnected().then((value) {
      if (value) {
        if (registerFormKey.currentState.validate()) {
          startLoading();
          auth
              .createUserWithEmailAndPassword(
                  email: user.email, password: valuePassword)
              .then((value) {
            user.id = auth.currentUser.uid;
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
              if (user.role == 0)
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DoctorDashboard()));
              else
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => PatientDashBoard()));
            }).catchError((onError) {
              stopLoading();
              Director.showError(context, Constants.SMW_ERROR);
            });
          }).catchError((var onError) {
            stopLoading();
            Director.showError(context, onError.message);
          });
        }
      } else {
        Director.showError(context, Constants.NO_INTERNET);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: HelloDocColors.colorPrimary,
      ),
      body: SafeArea(
        child: Container(
          height: height,
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
                            padding: const EdgeInsets.fromLTRB(11, 20, 11, 60),
                            child: Form(
                              key: registerFormKey,
                              child: Column(
                                children: [
                                  ToggleSwitch(
                                    minWidth: 90.0,
                                    activeBgColor: HelloDocColors.colorPrimary,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Color(0xffeceded),
                                    inactiveFgColor: Colors.grey[900],
                                    labels: [
                                      'Doctor',
                                      'Patient',
                                    ],
                                    onToggle: (index) {
                                      user.role = index;
                                      // type = index;
                                      print('switched to: $index');
                                    },
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  TextFormField(
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
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.grey)))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
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
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.grey)))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Email is required';
                                        }
                                        if (!EmailValidator.validate(value)) {
                                          return "Email is invalid";
                                        }
                                        user.email = value.trim();
                                        return null;
                                      },
                                      decoration: new InputDecoration(
                                          hintText: "Email",
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.grey)))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Password is required";
                                        }
                                        if (value.length < 6) {
                                          return 'Please enter valid password';
                                        }
                                        valuePassword = value.trim();
                                        return null;
                                      },
                                      decoration: new InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock_outline),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.grey)))),
                                  SizedBox(height: 38),
                                  TextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Password Confirmation is required";
                                        }
                                        if (value.length < 6) {
                                          return 'Please enter valid password';
                                        }
                                        valuePasswordConfirmation =
                                            value.trim();
                                        if (valuePassword !=
                                            valuePasswordConfirmation) {
                                          return "Password does not match";
                                        }
                                        return null;
                                      },
                                      decoration: new InputDecoration(
                                          hintText: "Password Confirmation",
                                          prefixIcon: Icon(Icons.lock_outline),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.grey)))),
                                  SizedBox(height: 38),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Already have an account? "),
                                        Text("LOGIN HERE",
                                            style: GoogleFonts.raleway(
                                                color:
                                                    HelloDocColors.colorPrimary,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      width: width,
                      child: Column(
                        children: [
                          ArgonButton(
                            height: 65,
                            roundLoadingShape: true,
                            width: width,
                            onTap: (startLoading, stopLoading, btnState) {
                              registerUser(startLoading, stopLoading);
                            },
                            child: Text(
                              "SIGN UP",
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
