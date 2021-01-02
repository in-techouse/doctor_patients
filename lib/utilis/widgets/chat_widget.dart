import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../HelloDocColors.dart';

class chat_widget extends StatelessWidget {
  String image, txt1, txt2, txt3;
  Function onInkWellTap;
  IconData icon1;
  double padding;
  chat_widget(
      {this.image,
      this.icon1,
      this.txt1,
      this.txt2,
      this.txt3,
      this.padding,
      this.onInkWellTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    Orientation orien = MediaQuery.of(context).orientation;
    bool screen = orien == Orientation.portrait ? true : false;

    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: InkWell(
        onTap: onInkWellTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(
                          image,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            txt1,
                            style: TextStyle(fontSize: 20, color: main_color),
                          ),
                          Text(txt2,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      myPopMenu(),
                      SizedBox(
                        height: 8,
                      ),
                      Text(txt3,
                          style: TextStyle(fontSize: 11, color: Colors.white)),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 0.3,
                  width: width,
                  color: main_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget myPopMenu() {
  return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Colors.white,
      onSelected: (value) {
        print("hello");
      },
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Center(
                    child: Text(
                  'Delete',
                  style: TextStyle(color: main_color),
                ))),
          ]);
}
