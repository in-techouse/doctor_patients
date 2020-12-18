// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import '../constants.dart';
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _fireStore = FirebaseFirestore.instance;
//   String messageData;
//   User loggedInUser;
//   getUserInfo() {
//     try
//     {
//       final user = _auth.currentUser;
//       if(user != null)
//       {
//         loggedInUser = user;
//         print(loggedInUser.email);
//       }
//     }
//     catch(e){
//       print(e);
//     }
//   }
//   void streams() async{
//     await for(var snapshots in _fireStore.collection('messages').snapshots()){
//       for(var messages in snapshots.docs){
//         print(messages);
//       }
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserInfo();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 //Implement logout functionality
//                 _auth.signOut();
//                 Navigator.pop(context);
//               }),
//         ],
//         title: Text('⚡️Chat'),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             StreamBuilder<QuerySnapshot>(
//               stream: _fireStore.collection('messages').snapshots(),
//               builder: (context, snapshot){
//                 if(!snapshot.hasData){}
//                 final messages = snapshot.data.docs;
//                 List<Text> messageWidgets = [];
//                 for(var message in messages){
//                   final messageText = message.data();
//                   // final messageSender = message.data();
//                   // final widgetText = MessageBubble(data: messageText);
//                   // messageWidgets.add(widgetText);
//                 }
//                 return Expanded(
//                   child: ListView(
//                     children: messageWidgets,
//                   ),
//                 );
//               }
//               ,
//             ),
//             Container(
//               // decoration: kMessageContainerDecoration,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         //Do something with the user input.
//                         messageData = value;
//                       },
//                       // decoration: kMessageTextFieldDecoration,
//                     ),
//                   ),
//                   FlatButton(
//                     onPressed: () {
//                       //Implement send functionality.
//                       _fireStore.collection('messages').add({
//                         'text' : messageData,
//                         'sender' : loggedInUser.email
//                       });
//                     },
//                     child: Text(
//                       'Send',
//                       // style: kSendButtonTextStyle,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class MessageBubble extends StatelessWidget {
//   String data;
//   MessageBubble({this.data});
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: Colors.yellow,
//         child: Text(data)
//     );
//   }
// }