import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER_FIELD = "number";
  static const ID_FIELD = "id";
  static const NAME_FIELD = "name";
  static const EMAIL_FIELD = "email";
  static const USER_TYPE_FIELD = "userType";
  static const ROOM_FIELD = "room";

  late String _number;
  late String _id;
  late String _name;
  late String _email;
  late String _userType;
  late String _room;

  // Constructor taking DocumentSnapshot as parameter
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    _number = data?[NUMBER_FIELD] as String? ?? "";
    _id = data?[ID_FIELD] as String? ?? "";
    _name = data?[NAME_FIELD] as String? ?? "";
    _email = data?[EMAIL_FIELD] as String? ?? "";
    _userType = data?[USER_TYPE_FIELD] as String? ?? "Regular";
    _room = data?[ROOM_FIELD] as String? ?? "";
  }

  // Getters for class fields
  String get number => _number;
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get userType => _userType;
  String get room => _room;
}
