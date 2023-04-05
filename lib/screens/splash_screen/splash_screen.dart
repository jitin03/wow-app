import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maven_class/screens/auth/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/shared_service.dart';
import '../../utils/config.dart';
import '../auth/verify_otp_screen.dart';
import '../provider/provider_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.center,
          matchTextDirection: true,
          repeat: ImageRepeat.noRepeat,
          image: AssetImage("assets/images/splash_light_background.png"),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
        decoration: BoxDecoration(
        shape: BoxShape.circle,
          border: Border.all(
            color: primaryColor,
            width: 3.0,
          ),
        ),
              child: ClipOval(
                child: Image(
                  image: AssetImage("assets/icons/ic_logo.png"),
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Text(
              "Wow Provider",
              style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> whereToGo() async {
    var isLoggedIn = await SharedService.isLoggedIn();
    // var isLoggedIn = false;

    Timer(Duration(seconds: 3), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderDashboardScreen(currentIndex: 0),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ));
      }
    });
  }
}
