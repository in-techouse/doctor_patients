class Constants {
  // Table Names
  static const String USERS = "Users";
  static const String TABLE_CHATS = "Chats";
  static const String TABLE_MESSAGES = "Messages";

  // Column Names
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String ID = "id";
  static const String ROLE = "role";
  static const String PHONE = "phone";
  static const String DOCTOR_ID = "doctorId";
  static const String PATIENT_ID = "patientId";
  static const String DOCTOR_NAME = "doctorName";
  static const String PATIENT_NAME = "patientName";
  static const String CHAT_ID = "chatId";
  static const String LAST_MESSAGE = "lastMessage";
  static const String TIME_STAMPS = "timeStamps";

  // Error Messages
  // ignore: non_constant_identifier_names
  static final String NO_INTERNET =
      "No internet connection found. Connect to a network and try again.";

  // ignore: non_constant_identifier_names
  static final String SMW_ERROR =
      "Something went wrong. Please try again later";

  // ignore: non_constant_identifier_names
  static final String COLD_FLU = "Cold Flu";

  // ignore: non_constant_identifier_names
  static final String ALLERGIES = "Allergies";

  // ignore: non_constant_identifier_names
  static final String CARDIO_VASCULAR = "Cardio Vascular";

  // ignore: non_constant_identifier_names
  static final String HAIR_FALL = "HairFall";

  // ignore: non_constant_identifier_names
  static final String DIABETES = "Diabetes";

  // ignore: non_constant_identifier_names
  static final String HEADACHE = "Headache";

  // ignore: non_constant_identifier_names
  static final String STOMACHACHE = "Stomachache";

  // ignore: non_constant_identifier_names
  static final List<String> DISEASES = [
    COLD_FLU,
    ALLERGIES,
    CARDIO_VASCULAR,
    HAIR_FALL,
    DIABETES,
    HEADACHE,
    STOMACHACHE
  ];
}
