import 'package:auberge/edit_details.dart';
import 'package:auberge/firstScreen.dart';
import 'package:auberge/view/nav_bar/add_complain.dart';
import 'package:auberge/view/nav_bar/add_mess_menu.dart';
import 'package:auberge/view/new_announce_screen.dart';
import 'package:auberge/view/email_auth/login_screen.dart';
import 'package:auberge/view/post_screen.dart';
import 'package:auberge/view/email_auth/signUp_screen.dart';
import 'package:auberge/view/splash.dart';
import 'package:auberge/view/user_one_time_details_screen.dart';
import 'package:flutter/material.dart';

import 'routes_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());
      case RoutesName.editScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditScreen());
      case RoutesName.post:
        if (arguments is int) {
          return MaterialPageRoute(
              builder: (BuildContext context) => PostScreen(
                    currentIndex: arguments,
                  ));
        } else {
          return MaterialPageRoute(builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          });
        }
      case RoutesName.oneTime:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserOneTimeDetailScreen());
      case RoutesName.addAnnounce:
        return MaterialPageRoute(
            builder: (BuildContext context) => CreateAnnouncementScreen());
      case RoutesName.addComplain:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddComplain());
      case RoutesName.mMenu:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddMessMenu());
      case RoutesName.firstScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => FirstScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
