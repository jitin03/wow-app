import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:maven_class/model/provide_profile_email.dart';
import 'package:maven_class/model/provider_profile_response_bck.dart';
import 'package:maven_class/model/provider_service_request.dart';
import 'package:maven_class/services/auth_service.dart';
import 'package:maven_class/services/shared_service.dart';
import 'package:maven_class/utils/config.dart';

class ProviderService {
  static var client = http.Client();

  Future<ProviderDetail> getProviderProfile() async {
    var loginDetails = await SharedService.loginDetails();

    final queryParameters = {
      'phoneNo': AUTHService.getUserPhoneNo(loginDetails!.jwt),
    };
    print(queryParameters);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };
    var url = Uri.http(
        Config.apiURL, Config.providerProfileByPhoneNoAPI, queryParameters);

    Response response = await http.get(url, headers: requestHeaders);
    print("provider profile");
    print(response.body);
    print(profileEmailFromJson(response.body).id!);
    if (response.statusCode == 200) {
      await SharedService.setProviderId(
        profileEmailFromJson(response.body).id!,
      );
      return profileEmailFromJson(response.body);
    } else {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ProviderProfileResponse> updateProviderServiceProfile(
      ProviderDetail serviceRequest, String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =
        Uri.http(Config.apiURL, Config.providerProfileAPI + "/${id}/update");

    Response response = await http.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(serviceRequest.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return provideProfileFromJson(response.body);
    } else {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<bool> saveProviderServiceProfile(
      ProviderProfileResponse serviceRequest) async {
    // var loginDetails = await SharedService.loginDetails();
    var userDetails = await SharedService.userDetails();
    print(userDetails);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userDetails!.accessToken}'
    };
    serviceRequest.userId = userDetails.userId;
    var url = Uri.http(Config.apiURL, Config.providerProfileAPI);

    print(requestHeaders);
    Response response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(serviceRequest.toJson()),
    );
    print(response.body);
    if (response.statusCode == 201) {
      await SharedService.setProviderId(
        response.body,
      );
      return true;
    } else {
      return false;
    }
  }
}

final providerServiceProvider =
    Provider<ProviderService>((ref) => ProviderService());
