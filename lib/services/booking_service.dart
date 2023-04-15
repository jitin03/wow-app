import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:maven_class/model/billing_request_model.dart';
import 'package:maven_class/model/billing_response_model.dart';
import 'package:maven_class/model/booking_model.dart';
import 'package:maven_class/model/booking_status.dart';
import 'package:maven_class/model/booking_status_response.dart';
import 'package:maven_class/services/shared_service.dart';
import 'package:maven_class/utils/config.dart';

import '../model/booking_update_status_response.dart';
import '../model/customer_booking_response.dart';

class BookingService {
  static var client = http.Client();

  Future<List<BookingResponseModel>> getProviderBooking(
      String providerId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };
    final queryParameters = {
      'providerId': providerId,
    };
    var url =
        Uri.http(Config.apiURL, Config.providerBookingAPI, queryParameters);

    print(providerId);
    Response response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      print("Empty");
      print(response.body);

      print("Empty");
      return welcomeFromJson(response.body);
    } else if (response.statusCode == 404) {
      return <BookingResponseModel>[];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> generateBilling(
      BillingRequest billingModel, String bookingId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.bookingServiceAPI + "${bookingId}/billing",
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(billingModel.toJson()),
    );
    print(billingModel.toJson());
    print(response.body);

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> updateBilling(
      BillingRequest billingModel, String bookingId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.bookingServiceAPI + "${bookingId}/billing",
    );

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(billingModel.toJson()),
    );

    print(billingModel.toJson());

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<BillingResponse>> getBillForBookingId(String bookingId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.bookingServiceAPI + "${bookingId}/billing",
    );

    var response = await client.get(
      url,
      headers: requestHeaders,

    );

    print(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return billingResponseFromJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CustomerBookingResponse>> getCustomerBooking(String bookingId) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url =
    Uri.http(Config.apiURL, Config.bookingServiceAPI+'${bookingId}');


    var response = await client.get(
      url,
      headers: requestHeaders,

    );
    print(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return customerBookingResponseFromJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<BillingResponse>> getCustomerBilling(String bookingId) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url =
    Uri.http(Config.apiURL, Config.bookingServiceAPI+'/${bookingId}/billing');


    var response = await client.get(
      url,
      headers: requestHeaders,

    );
    print(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return billingResponseFromJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<BookingStatusResponse> modifyBookingStatus(
      BookingStatus statuModel, bookingId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };

    var url = Uri.http(
      Config.apiURL,
      "/api/v1/booking/${bookingId}/status",
    );

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(statuModel.toJson()),
    );

    if (response.statusCode == 200) {
      return bookingStatusResponseFromJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  static Future<BookingUpdateStatusResponse> updateBookingStatus(
      BookingStatus statuModel, bookingId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.jwt}'
    };

    var url = Uri.http(
      Config.apiURL,
      "/api/v1/booking/${bookingId}/status",
    );

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(statuModel.toJson()),
    );

    if (response.statusCode == 200) {
      return bookingUpdateStatusResponseFromJson(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final bookingServiceProvider =
    Provider<BookingService>((ref) => BookingService());
