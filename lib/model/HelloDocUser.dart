import 'package:shared_preferences/shared_preferences.dart';

import '../director/Constants.dart';

class HelloDocUser {
  String email, id, phone, name;
  int role;

  HelloDocUser({
    this.email,
    this.id,
    this.phone,
    this.name,
    this.role,
  });

  factory HelloDocUser.fromJSON(Map<dynamic, dynamic> user) => HelloDocUser(
        email: user[Constants.EMAIL],
        id: user[Constants.ID],
        phone: user[Constants.PHONE],
        role: user[Constants.ROLE],
        name: user[Constants.NAME],
      );

  factory HelloDocUser.getUserObject(SharedPreferences prefs) => HelloDocUser(
        email: (prefs.getString(Constants.EMAIL)) == null
            ? ('')
            : (prefs.getString(Constants.EMAIL)),
        id: (prefs.getString(Constants.ID)) == null
            ? ('')
            : (prefs.getString(Constants.ID)),
        phone: (prefs.getString(Constants.PHONE)) == null
            ? ('')
            : (prefs.getString(Constants.PHONE)),
        role: (prefs.getInt(Constants.ROLE)) == null
            ? 0
            : (prefs.getInt(Constants.ROLE)),
        name: (prefs.getString(Constants.NAME)) == null
            ? ('')
            : (prefs.getString(Constants.NAME)),
      );

  static void setUserSession(HelloDocUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.NAME, user.name);
    prefs.setInt(Constants.ROLE, user.role);
    prefs.setString(Constants.PHONE, user.phone);
    prefs.setString(Constants.EMAIL, user.email);
    prefs.setString(Constants.ID, user.id);
  }

  static void deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

class Doctors {
  String email, id, phone, username;

  int role;

  Doctors({
    this.email,
    this.id,
    this.phone,
    this.username,
    this.role,
  });

  factory Doctors.fromJSON(Map<dynamic, dynamic> user) => Doctors(
        email: user[Constants.EMAIL],
        id: user[Constants.ID],
        phone: user[Constants.PHONE],
        role: user[Constants.ROLE],
        username: user[Constants.NAME],
      );

  factory Doctors.getUserObject(SharedPreferences prefs) => Doctors(
        email: (prefs.getString(Constants.EMAIL)) == null
            ? ('')
            : (prefs.getString(Constants.EMAIL)),
        id: (prefs.getString(Constants.ID)) == null
            ? ('')
            : (prefs.getString(Constants.ID)),
        phone: (prefs.getString(Constants.PHONE)) == null
            ? ('')
            : (prefs.getString(Constants.PHONE)),
        role: (prefs.getInt(Constants.ROLE)) == null
            ? ('')
            : (prefs.getInt(Constants.ROLE)),
        username: (prefs.getString(Constants.NAME)) == null
            ? ('')
            : (prefs.getString(Constants.NAME)),
      );
}
