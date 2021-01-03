import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String valueEmail;
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendPasswordRecoveryEmail(startLoading, stopLoading) {
    FocusScope.of(context).requestFocus(FocusNode());
    Director.isConnected().then((value) {
      if (value) {
        if (forgotPasswordFormKey.currentState.validate()) {
          startLoading();
          auth.sendPasswordResetEmail(email: valueEmail).then((value) {
            stopLoading();
            showSuccessMessage();
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

  void showSuccessMessage() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        title: 'RESET PASSWORD!',
        desc:
            "Instructions to reset your password has been sent to $valueEmail. Check your email and follow the instructions to reset your password.",
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        btnOkOnPress: () {
          Navigator.pop(context);
        })
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("RESET PASSWORD"),
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
                            key: forgotPasswordFormKey,
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
                                      valueEmail = value.trim();
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
                              sendPasswordRecoveryEmail(
                                  startLoading, stopLoading);
                            },
                            child: Text(
                              "SEND RECOVERY EMAIL",
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
