import 'package:doctor_app/doctor_ui/doctorChat.dart';
import 'package:doctor_app/model/constants.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/view/auth/Login_Screen.dart';
import 'package:doctor_app/view/patient_ui/Patient_DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScren extends StatefulWidget {
  SplashScren({Key key}) : super(key: key);

  @override
  _SplashScrenState createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  User user;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  List<Userss> Users = new List<Userss>();
  var userRole;

  loadUserInfo() {
    reference
        .child(Constants.USERS)
        .orderByChild(Constants.ROLE)
        .once()
        .then((data) {
      print('Data ${data.toString()}');
      Map<dynamic, dynamic> list = data.value;
      if (list != null) {
        list.forEach((value, v1) {
          print("Value: ${value.toString()}");
          if (v1 != null) {
            print("Value: ${v1.toString()}");
            try {
              Userss user = Userss.fromJSON(v1);
              print("?User Role is: ${user.role}");
              userRole = user.role;
              Users.add(user);
            } catch (e) {
              print('Exception: ${e.toString()}');
            }
          }
        });
        print('Data Snapshot ${data.value}');
      }
    }).catchError((var error) {});
  }

  // Widget sendRelevantScreen() {
  //   getCurrentUser().then((value) {
  //     if (value != null) {
  //       if (value.role == 0) {
  //         return DoctorChat();
  //       } else {
  //         return PatientDashBoard();
  //       }
  //     }
  //     return LoginScreen();
  //   }).catchError((onError) {
  //     return LoginScreen();
  //   });
  //   // user = auth.currentUser;
  //   // if (user != null || userRole == 0) {
  //   //   return DoctorChat();
  //   // } else if (user != null || userRole == 1) {
  //   //   return PatientDashBoard();
  //   // } else
  //   //   return LoginScreen();
  // }
  //
  Future<Userss> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Userss.getUserObject(prefs);
  }

  // @override
  // void initState() {
  // }

  Widget sendRelevantScreen() {
    return FutureBuilder<Userss>(
      future: getCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<Userss> u) {
        if (u != null && u.data != null) {
          if (u.data.role == 0) {
            return DoctorChat();
          } else {
            return PatientDashBoard();
          }
        }
        return LoginScreen();
      },
    );
    // return FutureBuilder<User>(
    //   future: FirebaseAuth.instance.currentUser,
    //   builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
    //     print(snapshot);
    //     if (snapshot.hasData) {
    //       User user = snapshot.data;
    //       return DashBoard();
    //     }
    //     return Wellcome();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: sendRelevantScreen(),
      title: new Text(
        'Doctor Patient',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
//      gradientBackground: new LinearGradient(
//          begin: Alignment.topLeft,
//          end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}
