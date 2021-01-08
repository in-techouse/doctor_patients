import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
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
  HelloDocChat chat = new HelloDocChat();
  HelloDocUser currentUser, otherUser;
  DatabaseReference database = FirebaseDatabase.instance.reference();
  DatabaseReference userReference, chatReference;
  bool isLoading = true;

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  ChatUser firstUser, secondUser;

  @override
  void initState() {
    super.initState();
    userReference = database.child(Constants.USERS);
    chatReference = database.child(Constants.TABLE_CHATS);
    loadAllDetails();
  }

  void loadAllDetails() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    currentUser = HelloDocUser.getUserObject(preferences);
    firstUser = ChatUser(name: currentUser.name, uid: currentUser.id);
    getOtherUser();
  }

  void getOtherUser() {
    userReference.child(widget.userId).once().then((value) {
      if (value != null && value.value != null) {
        otherUser = HelloDocUser.fromJSON(value.value);
        secondUser = ChatUser(name: otherUser.name, uid: otherUser.id);
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
        loadChatObject();
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
    chatReference.child(this.chatId).once().then((value) {
      if (value != null && value.value != null) {
        print("ChatScreen, Previous chat found");
        HelloDocChat tempChat = HelloDocChat.fromJSON(value.value);
        setState(() {
          chat = tempChat;
          isLoading = false;
        });
      } else {
        print("ChatScreen, No Previous chat found");
        HelloDocChat tempChat = new HelloDocChat();
        tempChat.chatId = this.chatId;
        tempChat.patientId =
            currentUser.role == 1 ? currentUser.id : otherUser.id;
        tempChat.doctorId =
            currentUser.role == 0 ? currentUser.id : otherUser.id;
        tempChat.patientName =
            currentUser.role == 1 ? currentUser.name : otherUser.name;
        tempChat.doctorName =
            currentUser.role == 0 ? currentUser.name : otherUser.name;
        tempChat.lastMessage = "";
        tempChat.timeStamps = 0;
        setState(() {
          chat = tempChat;
          isLoading = false;
        });
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      Director.showErrorWithClose(context, Constants.SMW_ERROR);
    });
  }

  void onSend(ChatMessage message) async {
    print("Message is: ${message.toJson()}");
    var documentReference = FirebaseFirestore.instance
        .collection(this.chatId)
        .document(DateTime.now().millisecondsSinceEpoch.toString());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        message.toJson(),
      );
    });
    chat.timeStamps = DateTime.now().millisecondsSinceEpoch;
    chat.lastMessage = message.text;
    chatReference.child(chat.chatId).set({
      Constants.CHAT_ID: chat.chatId,
      Constants.DOCTOR_ID: chat.doctorId,
      Constants.PATIENT_ID: chat.patientId,
      Constants.DOCTOR_NAME: chat.doctorName,
      Constants.PATIENT_NAME: chat.patientName,
      Constants.LAST_MESSAGE: chat.lastMessage,
      Constants.TIME_STAMPS: chat.timeStamps,
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(this.chatId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> items = snapshot.data.documents;
            var messages =
                items.map((i) => ChatMessage.fromJson(i.data())).toList();
            return DashChat(
              key: _chatViewKey,
              inverted: false,
              onSend: onSend,
              sendOnEnter: true,
              textInputAction: TextInputAction.send,
              user: firstUser,
              inputDecoration:
                  InputDecoration.collapsed(hintText: "Add message here..."),
              dateFormat: DateFormat('yyyy-MMM-dd'),
              timeFormat: DateFormat('HH:mm'),
              messages: messages,
              showUserAvatar: false,
              showAvatarForEveryMessage: false,
              scrollToBottom: true,
              inputMaxLines: 5,
              messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
              alwaysShowSend: false,
              inputTextStyle: TextStyle(fontSize: 16.0),
              inputContainerStyle: BoxDecoration(
                border: Border.all(width: 0.0),
                color: Colors.white,
              ),
              shouldShowLoadEarlier: false,
              showTraillingBeforeSend: true,
            );
          } else {
            return showLoadingBar();
          }
        });
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
