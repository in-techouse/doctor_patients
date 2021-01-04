import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatsTab extends StatefulWidget {
  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child(Constants.USERS);
  List<HelloDocUser> doctors = new List<HelloDocUser>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllChats();
  }

  void loadAllChats() {
    reference.orderByChild(Constants.ROLE).equalTo(0).once().then((data) {
      print('Data ${data.toString()}');
      Map<dynamic, dynamic> list = data.value;
      List<HelloDocUser> temp = new List<HelloDocUser>();
      if (list != null) {
        list.forEach((value, v1) {
          print("Value: ${value.toString()}");
          if (v1 != null) {
            print("Value: ${v1.toString()}");
            try {
              HelloDocUser user = HelloDocUser.fromJSON(v1);
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
        isLoading = false;
      });
    }).catchError((var error) {
      setState(() {
        isLoading = false;
      });
      Director.showError(context, Constants.SMW_ERROR);
    });
  }

  Widget showLoadingBar() {
    return Center(
      child: SpinKitHourGlass(
        color: HelloDocColors.colorPrimary,
      ),
    );
  }

  Widget showAllChats() {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.all(17.0),
          child: GestureDetector(
            onTap: () {
              print("Start Chat with Doctor: ${doctor.name}");
            },
            child: Card(
              elevation: 11,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: HelloDocColors.colorPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      doctor.email,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: HelloDocColors.colorPrimary, fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showLoadingBar(),
    );
  }
}
