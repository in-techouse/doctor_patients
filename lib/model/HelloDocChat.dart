import 'package:doctor_app/director/Constants.dart';

class HelloDocChat {
  String doctorId, patientId, doctorName, patientName, chatId, lastMessage;
  var timeStamps;

  HelloDocChat(
      {this.doctorId,
      this.patientId,
      this.doctorName,
      this.patientName,
      this.chatId,
      this.lastMessage,
      this.timeStamps});

  factory HelloDocChat.fromJSON(Map<dynamic, dynamic> chat) => HelloDocChat(
        doctorId: chat[Constants.DOCTOR_ID],
        patientId: chat[Constants.PATIENT_ID],
        doctorName: chat[Constants.DOCTOR_NAME],
        patientName: chat[Constants.PATIENT_NAME],
        chatId: chat[Constants.CHAT_ID],
        lastMessage: chat[Constants.LAST_MESSAGE],
        timeStamps: chat[Constants.TIME_STAMPS],
      );
}
