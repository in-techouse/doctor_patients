import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/doctor_ui/doctorChat.dart';
import 'package:doctor_app/model/constants.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/view/auth/Signup_Screen.dart';
import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:doctor_app/view/patient_ui/chats.dart';
import 'package:doctor_app/view/utilis/button.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPas = false;
  String valueEmail, valuePassword;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isWorking = false;
  String errorMessage = '';

  loginUser() {
    print("loginUser");
    FocusScope.of(context).requestFocus(FocusNode());
    errorMessage = "";
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: valueEmail, password: valuePassword)
        .then((value) {
      print("Auth success");
      String id = valueEmail.replaceAll("@", "-");
      id = id.replaceAll(".", "_");
      DatabaseReference reference =
          FirebaseDatabase.instance.reference().child(Constants.USERS);
      reference.child(id).once().then((userData) async {
        Userss user = Userss.fromJSON(userData.value);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.NAME, user.username);
        prefs.setInt(Constants.ROLE, user.role);
        prefs.setString(Constants.EMAIL, user.email);
        prefs.setString(Constants.ID, user.id);
        setState(() {
          isWorking = false;
        });
        if (user.role == 0)
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => DoctorChat()));
        else
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => PatientDashBoard()));
      }).catchError((var err) {
        print("Database error: ${err}");
        setState(() {
          isWorking = false;
        });
        errorMessage = 'Something went wrong.\nPlease try again later.';
        Director.showError(context, err);
      });
    }).catchError((var error) {
      print("Auth error: ${error.message}");
      print("Error");
      print(error);
      setState(() {
        isWorking = false;
      });
      Director.showError(context, error.message);
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
            height: 280,
            color: Color(0xff1e319d),
          ),
          Positioned(
            top: 100,
            left: 95,
            child: Text("Patient Care",
                style: GoogleFonts.aclonica(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23)),
          ),
          Positioned(
            top: 210,
            left: 30,
            child: Container(
              width: 300,
              height: 270,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          TextFormField(
                              onChanged: (value) {
                                valueEmail = value;
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
                            height: 15,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                valuePassword = value;
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
                                          new BorderSide(color: Colors.grey))))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 92,
            child: SignButton(
                screen: screen,
                width: screen ? width * 0.5 : height * 0.1,
                height: screen ? width * 0.14 : height * 0.1,
                txt: "LOGIN",
                txtColor: Colors.white,
                buttonColor: Color(0xff1e319d),
                borderColor: Colors.transparent,
                onPressed: () {
                  if (loginKey.currentState.validate()) {
                    print("button clicked");
                    setState(() {
                      isWorking = true;
                    });
                    loginUser();
                  }
                }),
          ),
          Positioned(
            top: 508,
            left: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.raleway(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (loginKey.currentState.validate()) {
                        print("button clicked");
                        setState(() {
                          isWorking = true;
                        });
                        loginUser();
                      }
                      // if (loginKey.currentState.validate()) {
                      //   try {
                      //     if (type == 0) {
                      //       final doctorResult =
                      //           await _auth.signInWithEmailAndPassword(
                      //               email: _email, password: _password);
                      //       if (doctorResult != null) {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => ChatScreen()));
                      //       }
                      //     } else {
                      //       final patientResult =
                      //           await _auth.signInWithEmailAndPassword(
                      //               email: _email, password: _password);
                      //       if (patientResult != null) {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     PatientDashBoard()));
                      //       }
                      //     }
                      //   } catch (e) {
                      //     print(e);
                      //   }
                      // }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text("Sign up",
                        style: GoogleFonts.raleway(
                            color: Color(0xff1e319d),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
