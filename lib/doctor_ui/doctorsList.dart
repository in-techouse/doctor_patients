import 'package:doctor_app/model/constants.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/services/database.dart';
import 'package:doctor_app/view/utilis/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  DatabaseMethods dbModels;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;
  List<Userss> doctorNames = List<Userss>();

  Future<Userss> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Userss.getUserObject(prefs);
  }

  var userRole;
  var doctorName;

  DatabaseReference reference = FirebaseDatabase.instance.reference();
  List<Userss> doctors = new List<Userss>();

  loadUserInfo() {
    reference
        .child(Constants.USERS)
        .orderByChild(Constants.ROLE)
        .equalTo(0)
        .once()
        .then((data) {
      print('Data ${data.toString()}');
      Map<dynamic, dynamic> list = data.value;
      List<Userss> temp = new List<Userss>();
      if (list != null) {
        list.forEach((value, v1) {
          print("Value: ${value.toString()}");
          if (v1 != null) {
            print("Value: ${v1.toString()}");
            try {
              Userss user = Userss.fromJSON(v1);
              print("?User Role is: ${user.role}");
              temp.add(user);
            } catch (e) {
              print('Exception: ${e.toString()}');
            }
          }
        });
        print('Data Snapshot ${data.value}');
      }
      setState(() {
        doctors = temp;
      });
    }).catchError((var error) {});
  }

  getUserInfo() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dbModels.loadUserInfo();
    getUserInfo();
    loadUserInfo();
  }

  // Widget doctorNameWidget(){
  //   return Card(
  //     child: Column(
  //       children: (List.generate(doctorName.length, (index) {
  //         return Card(
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: main_color,
  //                   ),
  //                   Text(doctorName),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       })),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: main_color,
        title: Text("Doctors List"),
      ),
      body: SafeArea(
          child: doctors.length > 0
              ? ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: doctors.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];

                    return ListTile(
                      title: Text(doctor.username),
                      subtitle: Text(doctor.email),
                    );
                  },
                )
              : Container()),
    );
  }
}
