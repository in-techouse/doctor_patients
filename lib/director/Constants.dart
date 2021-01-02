import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  // Table Names
  static const String USERS = "Users";

  // Column Names
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String ID = "id";
  static const String ROLE = "role";
  static const String PHONE = "phone";
  static const String TEXT = "text";
  static const String CHATS = "chats";
  static const String SENDER = "sender";
  static String myName = "";

  // Error Messages
  // ignore: non_constant_identifier_names
  static final String NO_INTERNET =
      "No internet connection found. Connect to a network and try again.";
  // ignore: non_constant_identifier_names
  static final String SMW_ERROR =
      "Something went wrong. Please try again later";
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
