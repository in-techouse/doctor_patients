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

  static void showSuccessWithClose(context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        title: 'BLOOD DONATION!',
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

  static String getChatId(uid1, uid2) {
    String sum = "";
    for (var i = 0; i < 10; i++) {
      var char1 = uid1.codeUnitAt(i);
      var char2 = uid2.codeUnitAt(i);
      sum = sum + (char1 + char2).toString();
    }
    print("Chat id is $sum");
    return sum;
  }
}
