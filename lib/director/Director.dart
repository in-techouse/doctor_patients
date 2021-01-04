import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Director {
  static Future<bool> isConnected() async {
    bool flag = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      flag = false;
    }
    return flag;
  }

  static void showError(context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        title: 'ERROR!',
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress: () {})
      ..show();
  }

  static void showErrorWithClose(context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        title: 'ERROR!',
        desc: message,
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        btnOkOnPress: () {
          Navigator.pop(context);
        })
      ..show();
  }

  static void popUntilRoot(context) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
      popUntilRoot(context);
    }
  }
}
