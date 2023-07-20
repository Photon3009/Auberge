import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = "number";
  static const ID = "id";

  late String _number;
  late String _id;
  late String _name;
  late String _email;
  late String _userType;
  late String _room;

//  getters
  String get number => _number;
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get userType=>_userType;
  String get room=>_room;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    _number = data?[NUMBER] as String? ?? "";
    _id = data?[ID] as String? ?? "";
    _name = data?["name"] as String? ?? "";
    _email = data?["email"] as String? ?? "";
    _userType=data?["userType"] as String? ?? "Regular";
    _room=data?["room"] as String? ?? "";
  }
}
