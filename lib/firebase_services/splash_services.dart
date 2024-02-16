import 'dart:async';

import 'package:auberge/utils/routes/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    // Delayed navigation based on user authentication status
    void navigateAfterDelay(String routeName, {Object? arguments}) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routeName, arguments: arguments);
      });
    }

    // If user is logged in, navigate to post screen after delay
    if (user != null) {
      navigateAfterDelay(RoutesName.post, arguments: 0);
    }
    // If user is not logged in, navigate to the first screen after delay
    else {
      navigateAfterDelay(RoutesName.firstScreen);
    }
  }
}
