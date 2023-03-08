import 'package:flutter/material.dart';

class Config {
  static const String appName = "Thinking!";
  static const String apiURL = '10.0.2.2:8989'; //PROD_URL
  static const loginAPI = "/api/v1/auth/login";
  static const requestOtpAPI = "/api/v1/auth/requestOtp";
  static const verifyOtpAPI = "/api/v1/auth/verifyOtp/";
  static const registerAPI = "/api/v1/auth/signup";
  static const providerBookingAPI = "/api/v1/booking/provider";
  static const providerProfileAPI="api/v1/providers";
  static const providerProfileByPhoneNoAPI="api/v1/providers/profile";
  static const bookingServiceAPI='/api/v1/booking/';



  static const List<String> appBarTitles = [
    "Dashboard",
    "Booking",
    // "Payment",
    "Profile",
  ];
  // static const userProfileAPI = "/users/user-Profile";
}

const APP_NAME = 'Handyman Services';
const DEFAULT_LANGUAGE = 'en';

const primaryColor = Color(0xFF5F60B9);
//var appFontFamily = GoogleFonts.workSans().fontFamily;

const DOMAIN_URL = ''; // Don't add slash at the end of the url
const BASE_URL = "$DOMAIN_URL/api/";

const IOS_LINK_FOR_PARTNER =
    "https://apps.apple.com/in/app/handyman-provider-app/id1596025324";

const ONESIGNAL_APP_ID = '';
const ONESIGNAL_REST_KEY = "";
const ONESIGNAL_CHANNEL_ID = "";

const TERMS_CONDITION_URL = 'https://iqonic.design/terms-of-use/';
const PRIVACY_POLICY_URL = 'https://iqonic.design/privacy-policy/';
const HELP_SUPPORT_URL = 'https://iqonic.desky.support/';
const PURCHASE_URL =
    'https://codecanyon.net/item/handyman-service-flutter-ondemand-home-services-app-with-complete-solution/33776097?s_rank=5';

const GOOGLE_MAPS_API_KEY = '';

const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';

DateTime todayDate = DateTime(2022, 8, 24);

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";
double defaultRadius = 8.0;
