import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

import '../model/login_response_model.dart';
import '../model/register_response.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

  static Future<VerifyOtpResonseModel?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return verifyOtpResponseJson(cacheData.syncData);
    }
  }


  static Future<RegisterResponseModel?> userDetails() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("user_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("user_details");

      return registerationResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setProviderId(
      String profileSetupResponse,
      ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "provider_id",
      syncData: profileSetupResponse,
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<String?> getProviderId() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("provider_id");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("provider_id");

      return cacheData.syncData;
    }
  }

  static Future<void> setLoginDetails(
    VerifyOtpResonseModel loginResponse,
  ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }
  static Future<void> setUserDetails(
      RegisterResponseModel loginResponse,
      ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "user_details",
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

   Future<void> logout() async {
    await APICacheManager().deleteCache("provider_id");
    await APICacheManager().deleteCache("login_details");
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   '/login',
    //   (route) => false,
    // );
  }
}
final sharedServiceProvider =
Provider<SharedService>((ref) => SharedService());
