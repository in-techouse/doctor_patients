import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/screens/auth/ForgotPassword.dart';
import 'package:doctor_app/screens/auth/SignupScreen.dart';
import 'package:doctor_app/screens/doctor_ui/DoctorDashboard.dart';
import 'package:doctor_app/screens/patient_ui/PatientDashboard.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String valueEmail, valuePassword;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child(Constants.USERS);

  loginUser(startLoading, stopLoading) {
    FocusScope.of(context).requestFocus(FocusNode());
    Director.isConnected().then((value) {
      if (value) {
        if (loginFormKey.currentState.validate()) {
          startLoading();
          auth
              .signInWithEmailAndPassword(
                  email: valueEmail, password: valuePassword)
              .then((value) {
            if (auth.currentUser != null) {
              reference.child(auth.currentUser.uid).once().then((value) {
                HelloDocUser user = HelloDocUser.fromJSON(value.value);
                HelloDocUser.setUserSession(user);
                stopLoading();
                Director.popUntilRoot(context);
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
            } else {
              stopLoading();
              Director.showError(context, Constants.SMW_ERROR);
            }
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
        title: Text("SIGN IN"),
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
                            key: loginFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return "Email is invalid";
                                      }
                                      valueEmail = value;
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                        hintText: "Email",
                                        prefixIcon: Icon(Icons.email_outlined),
                                        enabledBorder: new UnderlineInputBorder(
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
                                      valuePassword = value;
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                        hintText: "Password",
                                        prefixIcon: Icon(Icons.lock_outline),
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey)))),
                                SizedBox(height: 38),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Don't have an account? "),
                                      Text("CREATE ONE",
                                          style: GoogleFonts.raleway(
                                              color:
                                                  HelloDocColors.colorPrimary,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 38),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Forgot Your Password? "),
                                      Text("RECOVER HERE",
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
                    ],
                  ),
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
                              loginUser(startLoading, stopLoading);
                            },
                            child: Text(
                              "SIGN IN",
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
        ), // child: Stack(
      ),
    );
  }
}
