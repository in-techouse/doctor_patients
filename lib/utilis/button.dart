import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignButton extends StatelessWidget {
  String txt;
  Function onPressed;
  bool screen;
  double height, width;
  Color buttonColor, txtColor, borderColor;

  SignButton({
    this.width,
    this.height,
    this.screen,
    this.onPressed,
    this.txt,
    this.borderColor,
    this.buttonColor,
    this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        color: buttonColor,
        child: Center(
          child: Text(
            txt,
            style: GoogleFonts.raleway(fontSize: 18, color: Colors.white),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: borderColor)),
        onPressed: onPressed,
      ),
    );
  }
}
