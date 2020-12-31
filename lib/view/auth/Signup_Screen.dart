import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/model/constants.dart';
import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:doctor_app/view/utilis/button.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _id, _name, _eMail, _phoneNo, _password, _confirmPassword;
  int type = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isWorking = false;
  String errorMessage = "";

  // checkUserName() {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   errorMessage = "";
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   db.collection('doctor').add({
  //     'name' : _name,
  //     'email': _eMail,
  //     '_phoneNo' : _phoneNo,
  //     'role' : type,
  //   }).then((value) {
  //
  //   });
  //   db
  //       .reference()
  //       .child(Constants.USERS)
  //       .orderByChild(Constants.USERNAME)
  //       .equalTo(user.username)
  //       .once()
  //       .then((snapshot) {
  //     Map<dynamic, dynamic> users = snapshot.value;
  //     if (users != null && users.length > 0) {
  //       errorMessage =
  //       "The username is already taken. Please try something else";
  //       setState(() {
  //         isWorking = false;
  //       });
  //     } else {
  //       registeruser();
  //     }
  //   }).catchError((var err) {
  //     errorMessage = err.toString();
  //     setState(() {
  //       isWorking = false;
  //     });
  //   });
  // }
  registeruser() {
    errorMessage = "";
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(email: _eMail, password: _password)
        .then((value) {
      _id = _eMail.replaceAll("@", "-");
      _id = _id.replaceAll(".", "_");
      FirebaseDatabase data = FirebaseDatabase.instance;
      data.reference().child(Constants.USERS).child(_id).set({
        Constants.EMAIL: _eMail,
        Constants.NAME: _name,
        Constants.ID: _id,
        Constants.PHONE: _phoneNo,
        Constants.ROLE: type,
      }).then((r) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.EMAIL, _eMail);
        prefs.setString(Constants.NAME, _name);
        prefs.setString(Constants.ID, _id);
        prefs.setString(Constants.PHONE, _phoneNo);
        prefs.setInt(Constants.ROLE, type);
        setState(() {
          isWorking = false;
        });
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => LoginScreen()));
      }).catchError((var er) {
        setState(() {
          isWorking = false;
        });
        errorMessage = er.message;
      });
    }).catchError((var error) {
      setState(() {
        isWorking = false;
      });
      errorMessage = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            children: [],
          ),
          Container(
            height: height * 0.3,
            color: Color(0xff1e319d),
          ),
          Positioned(
            top: 30,
            left: 95,
            child: Text("Patient Care",
                style: GoogleFonts.aclonica(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23)),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left : width*0.1,top: height*0.1),
              width: width * 0.8,
              height: height*0.7,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ToggleSwitch(
                          minWidth: 90.0,
                          activeBgColor: Color(0xff5d8307),
                          activeFgColor: Colors.white,
                          inactiveBgColor: Color(0xffeceded),
                          inactiveFgColor: Colors.grey[900],
                          labels: [
                            'Doctor',
                            'Patient',
                          ],
                          onToggle: (index) {
                            type = index;
                            print('switched to: $index');
                          },
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TextFormField(
                            onChanged: (value) {
                              _name = value;
                            },
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Please Enter Valid Name';
                              } else
                                return null;
                            },
                            decoration: new InputDecoration(
                                hintText: "Name",
                                prefixIcon: Icon(Icons.person_outline),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)))),
                        SizedBox(
                          height: 13,
                        ),
                        TextFormField(
                            onChanged: (value) {
                              _eMail = value;
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Email is required...';
                              }
                              return EmailValidator.validate(val)
                                  ? null
                                  : "Invalid email address";
                            },
                            decoration: new InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email_outlined),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)))),
                        SizedBox(
                          height: 11,
                        ),
                        TextFormField(
                            onChanged: (value) {
                              _phoneNo = value;
                            },
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Please enter valid number';
                              } else
                                return null;
                            },
                            decoration: new InputDecoration(
                                hintText: "Phone no",
                                prefixIcon: Icon(Icons.phone),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)))),
                        SizedBox(
                          height: 11,
                        ),
                        TextFormField(
                            onChanged: (value) {
                              _password = value;
                            },
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Please enter valid password';
                              } else
                                return null;
                            },
                            decoration: new InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey)))),
                        SizedBox(
                          height: 11,
                        ),
                        TextFormField(
                            onChanged: (value) {
                              _confirmPassword = value;
                            },
                            validator: (value) {
                              if (value == null || value != _password) {
                                return 'Please enter same password';
                              } else
                                return null;
                            },
                            decoration: new InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.grey))))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height*0.74,
            left: width * 0.23,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignButton(
                  screen: screen,
                  width: screen ? width * 0.5 : height * 0.1,
                  height: screen ? width * 0.14 : height * 0.1,
                  txt: "SIGN UP",
                  txtColor: Colors.white,
                  buttonColor: Color(0xff1e319d),
                  borderColor: Colors.transparent,
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      registeruser();
                      // try {
                      //
                      //   // final doctorResult =
                      //   //     await _auth.createUserWithEmailAndPassword(
                      //   //         email: _eMail, password: _password);
                      //
                      //   // if(type == "0")
                      //   //   {
                      //   //     final doctorResult = await _auth.createUserWithEmailAndPassword(email: _eMail, password: _password);
                      //   //     if(doctorResult != null) {
                      //   //       Navigator.push(
                      //   //           context,
                      //   //           MaterialPageRoute(
                      //   //               builder: (context) => PatientDashBoard()));
                      //   //     }
                      //   //
                      //   //   }
                      //   // else{
                      //   //   setState(() {
                      //   //     isWorking = true;
                      //   //   });
                      //   //   registeruser();
                      //   //   // final patientResult = await _auth.createUserWithEmailAndPassword(email: _eMail, password: _password);
                      //   //   // if(patientResult != null) {
                      //   //   //   Navigator.push(
                      //   //   //       context,
                      //   //   //       MaterialPageRoute(
                      //   //   //           builder: (context) => PatientDashBoard()));
                      //   //   // }
                      //   // }
                      // } catch (e) {
                      //   print(e);
                      // }
                    }

                    // Signin(context);
                  }),
            ),
          ),
          Positioned(
            top: height * 0.88,
            left: width * 0.3,
            child: Row(
              children: [
                Text(
                  "Already member?",
                  style: GoogleFonts.raleway(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Login",
                      style: GoogleFonts.raleway(
                          color: Color(0xff1e319d),
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
