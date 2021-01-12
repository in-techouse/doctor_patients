import 'package:doctor_app/director/Constants.dart';

class HelloDocBloodDonation {
  String id, ownerId, name, phoneNumber, bloodGroup, city;

  HelloDocBloodDonation(
      {this.id,
      this.ownerId,
      this.name,
      this.phoneNumber,
      this.bloodGroup,
      this.city});

  factory HelloDocBloodDonation.fromJSON(Map<dynamic, dynamic> user) =>
      HelloDocBloodDonation(
        id: user[Constants.ID],
        name: user[Constants.NAME],
        ownerId: user[Constants.OWNER_ID],
        phoneNumber: user[Constants.PHONE],
        bloodGroup: user[Constants.BLOOD_GROUP],
        city: user[Constants.CITY],
      );
}
