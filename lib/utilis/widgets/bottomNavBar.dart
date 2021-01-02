import 'package:doctor_app/screens/patient_ui/PatientDashboard.dart';
import 'package:doctor_app/screens/patient_ui/diseases.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/material.dart';

import 'patientChat.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  Widget getPage() {
    if (selectedIndex == 0) {
      return Diseases();
    }
    if (selectedIndex == 1) {
      return ChatDetail();
    }
    return PatientDashBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.grey[200],
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Color(0xff1e319d),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        items: [
          FFNavigationBarItem(
            iconData: Icons.warning_amber_sharp,
            label: 'Diseases',
          ),
          FFNavigationBarItem(
            iconData: Icons.chat_bubble_outline_sharp,
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
