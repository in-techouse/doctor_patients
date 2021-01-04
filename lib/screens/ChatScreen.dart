import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/director/Director.dart';
import 'package:doctor_app/model/HelloDocChat.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:doctor_app/utilis/HelloDocColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({this.userId});

  String userId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatId = "";
  HelloDocChat chat;
  HelloDocUser currentUser, otherUser;
  DatabaseReference database = FirebaseDatabase.instance.reference();
  DatabaseReference userReference, chatReference, messageReference;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userReference = database.child(Constants.USERS);
    chatReference = database.child(Constants.TABLE_CHATS);
    messageReference = database.child(Constants.TABLE_MESSAGES);
    loadAllDetails();
  }

  void loadAllDetails() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    currentUser = HelloDocUser.getUserObject(preferences);
    getOtherUser();
  }

  void getOtherUser() {
    userReference.child(widget.userId).once().then((value) {
      if (value != null) {
        otherUser = HelloDocUser.fromJSON(value.value);
        var sum = "";
        for (var i = 0; i < 10; i++) {
          var char1 = currentUser.id.codeUnitAt(i);
          var char2 = otherUser.id.codeUnitAt(i);
          sum = sum + (char1 + char2).toString();
        }
        print("Chat id is $sum");
        setState(() {
          chatId = sum;
        });
        // HelloDocChat tempChat = new HelloDocChat();
        // tempChat.chatId = sum;
        // tempChat.patientId =
        //     currentUser.role == 1 ? currentUser.id : otherUser.id;
        // tempChat.doctorId =
        //     currentUser.role == 0 ? currentUser.id : otherUser.id;
        // tempChat.patientName =
        //     currentUser.role == 1 ? currentUser.name : otherUser.name;
        // tempChat.doctorName =
        //     currentUser.role == 0 ? currentUser.name : otherUser.name;
      } else {
        setState(() {
          isLoading = false;
        });
        Director.showErrorWithClose(context, Constants.SMW_ERROR);
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      Director.showErrorWithClose(context, Constants.SMW_ERROR);
    });
  }

  void loadChatObject() {
    chatReference.child(chatId).once().then((value) {
      if (value != null) {
        HelloDocChat tempChat = HelloDocChat.fromJSON(value.value);
        if (tempChat != null) {
          setState(() {
            chat = tempChat;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Director.showErrorWithClose(context, Constants.SMW_ERROR);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        Director.showErrorWithClose(context, Constants.SMW_ERROR);
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      Director.showErrorWithClose(context, Constants.SMW_ERROR);
    });
  }

  Widget showLoadingBar() {
    return Center(
      child: SpinKitHourGlass(
        color: HelloDocColors.colorPrimary,
      ),
    );
  }

  Widget showChat() {
    return Text("Display Chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHAT SCREEN"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: HelloDocColors.colorPrimary,
      ),
      body: SafeArea(
        child: isLoading ? showLoadingBar() : showChat(),
      ),
    );
  }
}
