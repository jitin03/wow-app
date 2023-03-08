import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/app_theme.dart';
import 'package:maven_class/model/revenue_chart_data.dart';
import 'package:maven_class/screens/auth/registeration_screen.dart';

import 'package:maven_class/screens/auth/sign_in_screen.dart';
import 'package:maven_class/screens/auth/verify_otp_screen.dart';
import 'package:maven_class/screens/provider/laundry_generate_bill.dart';

import 'package:maven_class/screens/provider/provider_booking_screen.dart';
import 'package:maven_class/screens/provider/provider_dashboard_screen.dart';
import 'package:maven_class/screens/provider/provider_profile.dart';
import 'package:maven_class/screens/provider/provider_services.dart';
import 'package:maven_class/screens/splash_screen/splash_screen.dart';
List<RevenueChartData> chartData = [];
void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider App',
      theme: AppTheme.lightTheme,
      //mean first screen

      //define the routes file here in order to access the routes any where all over the app
      routes: {
        // '/': (context) => ProviderDashboardScreen(currentIndex:0),
        // '/': (context) => ProviderDashboardScreen(currentIndex:0),
        '/profile': (context) => ProviderDashboardScreen(currentIndex:2),
        '/': (context) => SplashScreen(),
        '/sigin': (context) =>  SignIn(),
        '/verifyOtp': (context) =>  VerifyOtp(),
        "/booking":(context)=> ProviderDashboardScreen(currentIndex:1),
        '/register':(context)=>ProviderRegistrationScreen(),
        '/dashboard': (context) =>  ProviderDashboardScreen(currentIndex:0),

      },

    );
  }
}



