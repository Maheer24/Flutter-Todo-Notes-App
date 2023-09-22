import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase_services/splash_services.dart';
import '../palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "Zenlist",
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              fontSize: 50,
              color: Palette.lightBlackColor,
            ),
          ),
        ),
      ),
    );
  }
}
