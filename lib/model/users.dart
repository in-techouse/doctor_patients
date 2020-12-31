import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class Userss {
  String email, id, phone, username;

  int role;

  Userss({
    this.email,
    this.id,
    this.phone,
    this.username,
    this.role,
  });

  factory Userss.fromJSON(Map<dynamic, dynamic> user) => Userss(
        email: user[Constants.EMAIL],
        id: user[Constants.ID],
        phone: user[Constants.PHONE],
        role: user[Constants.ROLE],
        username: user[Constants.NAME],
      );

  factory Userss.getUserObject(SharedPreferences prefs) => Userss(
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