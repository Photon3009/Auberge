import 'package:auberge/data/models/user.dart';
import 'package:auberge/viewmodel/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  void setUser() async {
    final UserServices _userServicse = UserServices();
    final user = FirebaseAuth.instance.currentUser;
    var userModel = await _userServicse.getUserById(user!.uid);
    _user = userModel;
    notifyListeners();
  }

  UserModel? get user => _user;
}
