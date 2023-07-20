import 'dart:async';

import 'package:auberge/utils/routes/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutesName.post, arguments: 0);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutesName.firstScreen);
      });
    }
  }
}
