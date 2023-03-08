import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:maven_class/model/login_response_model.dart';
import 'package:maven_class/model/register_response.dart';
import 'package:maven_class/model/registration_request_model.dart';
import 'package:maven_class/model/request_otp_response.dart';
import 'package:maven_class/model/user_model.dart';
import 'package:maven_class/services/shared_service.dart';
import 'package:maven_class/utils/config.dart';
import 'package:riverpod/riverpod.dart';

class AUTHService {
  static var client = http.Client();

  Future<bool> login(
    UserModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    print(url);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        verifyOtpResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  Future<VerifyOtpResonseModel> verifyUserWithOtp(
    UserModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.verifyOtpAPI,
    );

    print(model.toJson());

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(response.body);

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        verifyOtpResponseJson(
          response.body,
        ),
      );

      return verifyOtpResponseJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<RequestOtpResponse> getRequestOtp(
    String phoneNo,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.requestOtpAPI + "/" + phoneNo,
    );

    print(url);

    var response = await http.get(
      url,
      headers: requestHeaders,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return requestOtpResponseFromJson(response.body);
    } else {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<RegisterResponseModel> register(
    RegistrationRequest model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    print(model.toJson());
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    // if (response.statusCode == 200) {
    //   await SharedService.setLoginDetails(
    //     verifyOtpResponseJson(
    //       response.body,
    //     ),
    //   );
    // }
    if (response.statusCode == 200) {
      return registerationResponseJson(response.body);
    } else {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }


  }

  static Object getUserPhoneNo(token) {
    var email;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    decodedToken.forEach((k, v) {
      if (k == "sub") {
        // email=v;
        email = v;
      }
    });
    return email;
  }
}

final authServiceProvider = Provider<AUTHService>((ref) => AUTHService());
