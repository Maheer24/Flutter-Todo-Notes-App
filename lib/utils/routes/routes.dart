import 'package:flutter/material.dart';
import 'package:zenlist1/ui/pages/create_note_page.dart';
import 'package:zenlist1/ui/pages/notesPage.dart';
import '../../ui/auth/login_screen.dart';
import '../../ui/auth/signup_screen.dart';
import '../../ui/pages/home.dart';
import '../../ui/splash_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case RouteName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case RouteName.signupScreen:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );

      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );

      case RouteName.createNotePage:
        return MaterialPageRoute(
          builder: (context) => CreateNotePage(),
        );

      case RouteName.notePage:
        return MaterialPageRoute(
          builder: (context) => NotesPage(),
      );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("No route defined"),
              ),
            );
          },
        );
    }
  }
}
