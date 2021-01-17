import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/model/HelloDocChat.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/screens/ChatScreen.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsTab extends StatefulWidget {
  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child(Constants.TABLE_CHATS);
  List<HelloDocChat> chats = List<HelloDocChat>.empty(growable: true);
  bool isLoading = true;
  HelloDocUser currentUser;

  @override
  void initState() {
    super.initState();
    loadAllChats();
  }

  void loadAllChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = HelloDocUser.getUserObject(prefs);

    String orderBy =
        currentUser.role == 0 ? Constants.DOCTOR_ID : Constants.PATIENT_ID;

    print("Order by $orderBy");
    reference
        .orderByChild(orderBy)
        .equalTo(currentUser.id)
        .onValue
        .listen((event) {
      print("Event: ${event.toString()}");
      print("Event Snapshot: ${event.snapshot.toString()}");
      print("Event Snapshot Value: ${event.snapshot.value.toString()}");
      setState(() {
        isLoading = true;
        chats = List<HelloDocChat>.empty(growable: true);
      });
      if (event != null &&
          event.snapshot != null &&
          event.snapshot.value != null) {
        Map<dynamic, dynamic> list = event.snapshot.value;
        List<HelloDocChat> temp = new List<HelloDocChat>.empty(growable: true);
        list.forEach((key, value) {
          print("Value: ${value.toString()}");
          HelloDocChat chat = HelloDocChat.fromJSON(value);
          if (chat != null) {
            temp.add(chat);
          }
        });
        temp.sort((a, b) {
          var aDate = a.timeStamps;
          var bDate = b.timeStamps;
          return bDate.compareTo(aDate);
        });
        setState(() {
          isLoading = false;
          chats = temp;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Widget showLoadingBar() {
    return Center(
      child: SpinKitHourGlass(
        color: HelloDocColors.colorPrimary,
      ),
    );
  }

  void showDeleteConfirmation(HelloDocChat chat) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        title: 'ARE YOU SURE!',
        desc: "Are you sure to delete this chat?",
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          setState(() {
            isLoading = true;
          });
          var chatCollectionRef =
              FirebaseFirestore.instance.collection(chat.chatId);
          chatCollectionRef.snapshots().forEach((element) {
            for (QueryDocumentSnapshot snap in element.docs) {
              snap.reference.delete();
            }
          });
          reference.child(chat.chatId).remove();
          setState(() {
            isLoading = false;
          });
        })
      ..show();
  }

  Widget showAllChats() {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        HelloDocChat chat = chats[index];
        DateTime chatTime =
            DateTime.fromMillisecondsSinceEpoch(chat.timeStamps);
        return Padding(
          padding: const EdgeInsets.all(17.0),
          child: GestureDetector(
            onLongPress: () {
              showDeleteConfirmation(chats[index]);
            },
            onTap: () {
              print("Start Chat with Doctor: ${chat.chatId}");
              String uId =
                  currentUser.role == 0 ? chat.patientId : chat.doctorId;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            userId: uId,
                          )));
            },
            child: Card(
              elevation: 11,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.role == 0
                          ? chat.patientName
                          : chat.doctorName,
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
                      chat.lastMessage,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: HelloDocColors.colorPrimary, fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${chatTime.day}/${chatTime.month}/${chatTime.year} ${chatTime.hour}:${chatTime.minute}",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
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
    return isLoading == true ? showLoadingBar() : showAllChats();
  }
}
