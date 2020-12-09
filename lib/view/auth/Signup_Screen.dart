import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:doctor_app/view/utilis/button.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'Login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: [],
            ),
            Container(
              height: 280,
              color: Color(0xff1e319d),
            ),
            Positioned(
              top: 80,
              left: 95,
              child: Text("Patient Care",
                  style: GoogleFonts.aclonica(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
            ),
            Positioned(
              top: 150,
              left: 20,
              child: Container(
                width: 320,
                height: 400,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(

                      children: [
                        ToggleSwitch(
                          minWidth: 90.0,
                          initialLabelIndex: 0,
                          activeBgColor: Color(0xff5d8307),
                          activeFgColor: Colors.white,
                          inactiveBgColor: Color(0xffeceded),
                          inactiveFgColor: Colors.grey[900],
                          labels: ['Doctor', 'Patient',],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TextFormField(
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
            Positioned(
              top: 509,
              left: 90,
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PatientDashBoard()));
                      // Signin(context);
                    }),
              ),
            ),
            Positioned(
              top: 600,
              left: 80,
              child: Row(
                children: [
                  Text(
                    "Already member?",
                    style: GoogleFonts.raleway(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                    },
                    child: Text("Login",
                        style: GoogleFonts.raleway(
                            color: Color(0xff1e319d), fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
