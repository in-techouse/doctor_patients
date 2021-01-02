import 'package:doctor_app/director/Constants.dart';
import 'package:doctor_app/model/HelloDocUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseMethods {
  // Future<void> addUserInfo(userData) async {
  //   FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // getUserInfo(String email) async {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where("userEmail", isEqualTo: email)
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // searchByName(String searchField) {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where('userName', isEqualTo: searchField)
  //       .get();
  // }
  //
  // Future<bool> addChatRoom(chatRoom, chatRoomId) {
  //   FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(chatRoomId)
  //       .set(chatRoom)
  //       .catchError((e) {
  //     print(e);
  //   });
  // }
  //
  // getChats(String chatRoomId) async{
  //   return FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .orderBy('time')
  //       .snapshots();
  // }
  //
  //
  // Future<void> addMessage(String chatRoomId, chatMessageData){
  //
  //   FirebaseFirestore.instance.collection("chatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .add(chatMessageData).catchError((e){
  //         print(e.toString());
  //   });
  // }
  //
  // getUserChats(String itIsMyName) async {
  //   return await FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .where('users', arrayContains: itIsMyName)
  //       .snapshots();
  // }
  List<HelloDocUser> Users = new List<HelloDocUser>();
  var userRole;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference();

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
              HelloDocUser user = HelloDocUser.fromJSON(v1);
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
    }).catchError((var error) {});
  }
}
