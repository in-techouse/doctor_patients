import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/model/constants.dart';
import 'package:doctor_app/model/users.dart';
import 'package:doctor_app/services/database.dart';
import 'package:doctor_app/view/auth/Login_Screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatDetail extends StatefulWidget {
  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  DatabaseMethods dbMethods;
  String messageData;
  User loggedInUser;
  var userRole;

  DatabaseReference reference = FirebaseDatabase.instance.reference();
  List<Userss> Users = new List<Userss>();
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
    }).catchError((var error) {
    });
  }
  getUserInfo() {
    try
    {
      final user = _auth.currentUser;
      if(user != null)
      {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }
  void streams() async{
    await for(var snapshots in _fireStore.collection('messages').snapshots()){
      for(var messages in snapshots.docs){
        print(messages);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    loadUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));              }),
        ],
        title: Text('Chat with Doctor'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final role = message.data()['role'];

                  final currentUser = role;

                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == role,
                  );

                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageData = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _fireStore.collection('messages').add({
                        'text' : messageData,
                        'sender' : loggedInUser.email,
                        'role' : userRole,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
