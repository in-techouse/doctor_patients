import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'patientChat.dart';
import 'chat_widget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: darkBlue,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Today",style: TextStyle(color: main_color,fontSize: 18),),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(12, (index) {
                    return chat_widget(padding: 20,image: "assets/images/logo.png",txt1: "Sarah Ross",txt2: "Message Content",txt3: "Just Now",onInkWellTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail()));}, icon1: Icons.more_horiz,);
                  },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
