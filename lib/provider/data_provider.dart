import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/billing_request_model.dart';
import 'package:maven_class/model/billing_response_model.dart';
import 'package:maven_class/model/booking_model.dart';
import 'package:maven_class/model/login_response_model.dart';
import 'package:maven_class/model/provide_profile_email.dart';
import 'package:maven_class/model/provider_profile_response_bck.dart';
import 'package:maven_class/model/request_otp_response.dart';
import 'package:maven_class/model/service_cart.dart';
import 'package:maven_class/model/user_model.dart';
import 'package:maven_class/provider/services_cart.dart';
import 'package:maven_class/provider/sharedpref/shared_preference_helper.dart';
import 'package:maven_class/services/auth_service.dart';
import 'package:maven_class/services/booking_service.dart';
import 'package:maven_class/services/provider_service.dart';
import 'package:maven_class/services/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/booking_status.dart';
import '../model/booking_status_response.dart';
import '../model/update_booking_request.dart';
import '../model/update_booking_status.dart';

final sharedPreferences =
    FutureProvider((_) async => await SharedPreferences.getInstance());
final sharedPreferencesHelper = Provider(
    (ref) => SharedPreferencesHelper(ref.watch(sharedPreferences).maybeWhen(
          data: (value) => value,
          orElse: () => null,
        )));

// final cartProvider = StateNotifierProvider<ServicesNotifier, Services>(
//     (ref) => ServicesNotifier(Services(name: "", price: 1, quantity: 1)));


final bookingDataProvider =
    FutureProvider<List<BookingResponseModel>>((ref) async {
  final resp = ref.watch(providerProfileDataProvider);
  return ref.watch(bookingServiceProvider).getProviderBooking(resp.value!.id!);
});




// Billing Screen provider
final billingScreenDataProvider =
FutureProvider<ProviderHomeData>((ref) async {
  final resp = ref.watch(providerProfileDataProvider);
  final profileData = ref.watch(providerProfileDataProvider.future);
  final bookingData = ref.watch(bookingDataProvider.future);

  return ProviderHomeData(
    bookingData: await bookingData,
    profileData: await profileData,
  );
});

final providerProfileDataProvider = FutureProvider<ProviderDetail>((ref) async {
  return ref.watch(providerServiceProvider).getProviderProfile();
});

final allbookingProvider = FutureProvider<List<BookingResponseModel>>((ref) async {
  return ref.watch(bookingServiceProvider).getAllBooking();
});

final shareServiceDataProvider = FutureProvider<void>((ref) async {
  return ref.read(sharedServiceProvider).logout();
});

final authDataProvider = FutureProvider.autoDispose
    .family<RequestOtpResponse, String>((ref, phoneNo) async {
  return ref.watch(authServiceProvider).getRequestOtp(phoneNo);
});

final billingDataProvider = FutureProvider.autoDispose
    .family<List<BillingResponse>, String>((ref, bookingId) async {
  return ref.watch(bookingServiceProvider).getBillForBookingId(bookingId);
});

final billingDetailDataProvider = FutureProvider.autoDispose.family<List<BillingResponse>,String>((ref,id) async {
  return ref.watch(bookingServiceProvider).getCustomerBilling(id);
});

final generateBillState = FutureProvider.autoDispose.family<GenerateBillData,String>((ref,id) async {
  final profileData = ref.watch(providerProfileDataProvider.future);
  final billingResponse =  ref.watch(bookingServiceProvider).getCustomerBilling(id);

  return GenerateBillData(
    billingResponse: await billingResponse,
    profileData: await profileData,
  );
});

class GenerateBillData{

  final List<BillingResponse> billingResponse;
  final ProviderDetail profileData;
  GenerateBillData({
    required this.billingResponse,
    required this.profileData,
  });
}

final providerHomStats = FutureProvider<ProviderHomeData>((ref) async {
  final profileData = ref.watch(providerProfileDataProvider.future);
  final bookingData = ref.watch(bookingDataProvider.future);

  return ProviderHomeData(
    bookingData: await bookingData,
    profileData: await profileData,
  );
});

class ProviderHomeData {
  final List<BookingResponseModel> bookingData;
  final ProviderDetail profileData;

  ProviderHomeData({
    required this.bookingData,
    required this.profileData,
  });
}

class AuthOtpNotifier extends ChangeNotifier {
  AuthOtpNotifier(this.ref) : super();
  final Ref ref;

  Future<RequestOtpResponse> requestOtp(String phoneNo) async {
    final service = ref.read(authServiceProvider);
    late RequestOtpResponse resp;

    resp = await service.getRequestOtp(phoneNo);
    return resp;
  }

  Future<VerifyOtpResonseModel> verifyOtpCode(UserModel request) async {
    final service = ref.read(authServiceProvider);
    late VerifyOtpResonseModel resp;

    resp = await service.verifyUserWithOtp(request);
    return resp;
  }
}

final authOtpProvider = ChangeNotifierProvider.autoDispose((ref) {
  return AuthOtpNotifier(ref);
});

class ProviderProfileNotifier extends ChangeNotifier {
  ProviderProfileNotifier(this.ref) : super();
  final Ref ref;

  Future<ProviderProfileResponse> updateProviderProfile(
      ProviderDetail request, String id) async {
    final service = ref.read(providerServiceProvider);
    late ProviderProfileResponse resp;

    resp = await service.updateProviderServiceProfile(request, id);
    return resp;
  }
}

class BookingNotifier extends ChangeNotifier {
  BookingNotifier(this.ref) :super();
  final Ref ref;

  Future<String> generateBilling(
      BillingRequest request, String id) async {
    final service = ref.read(bookingServiceProvider);
    late String resp;

    resp = await service.generateBilling(request, id);
    return resp;
  }
  Future<BookingStatusResponse> modifyBookingStatus(
      BookingStatus request, String bookingId) async {
    final service = ref.read(bookingServiceProvider);
    late BookingStatusResponse resp;

    resp = await service.modifyBookingStatus(request, bookingId);
    return resp;
  }
  Future<String> updateBilling(
      BillingRequest request, String id) async {
    final service = ref.read(bookingServiceProvider);
    late String resp;

    resp = await service.updateBilling(request, id);
    return resp;
  }
}

final billingProvider = ChangeNotifierProvider.autoDispose((ref) {
  return BookingNotifier(ref);
});

final providerProfileProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ProviderProfileNotifier(ref);
});


