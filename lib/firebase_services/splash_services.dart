import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.homeScreen);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.loginScreen);
      });
    }
  }
}
