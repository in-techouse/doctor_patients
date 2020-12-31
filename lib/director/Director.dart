import 'package:awesome_dialog/awesome_dialog.dart';

class Director {
  static void showError(context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        title: 'ERROR!',
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress: () {})
      ..show();
  }
}
