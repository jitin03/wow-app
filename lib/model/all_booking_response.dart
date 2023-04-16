import 'dart:convert';


List<AllBookingResponse> allBookingResponseFromJson(String str) =>
    List<AllBookingResponse>.from(
        json.decode(str).map((x) => AllBookingResponse.fromJson(x)));
String allBookingResponseToJson(AllBookingResponse data) =>
    json.encode(data.toJson());

class AllBookingResponse {
  final String? status;
  final String? paymentStatus;
  final String? paymentMode;
  final String? bookingTime;
  final String? bookingAddress;
  final String? grossAmount;
  final List<ServiceLists>? serviceLists;
  final num? bookingId;
  final List<String>? customerId;
  final List<num>? customerPhoneNo;
  final List<String>? customerEmail;
  final List<String>? customerName;
  final List<num>? providerPhoneNo;
  final List<dynamic>? providerAddress;
  final List<String>? providerId;
  final List<String>? providerName;

  AllBookingResponse({
    this.status,
    this.paymentStatus,
    this.paymentMode,
    this.bookingTime,
    this.bookingAddress,
    this.grossAmount,
    this.serviceLists,
    this.bookingId,
    this.customerId,
    this.customerPhoneNo,
    this.customerEmail,
    this.customerName,
    this.providerPhoneNo,
    this.providerAddress,
    this.providerId,
    this.providerName,
  });

  AllBookingResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        paymentStatus = json['paymentStatus'] as String?,
        paymentMode = json['paymentMode'] as String?,
        bookingTime = json['bookingTime'] as String?,
        bookingAddress = json['bookingAddress'] as String?,
        grossAmount = json['grossAmount'] as String?,
        serviceLists = (json['serviceLists'] as List?)?.map((dynamic e) => ServiceLists.fromJson(e as Map<String,dynamic>)).toList(),
        bookingId = json['bookingId'] as num?,
        customerId = (json['customerId'] as List?)?.map((dynamic e) => e as String).toList(),
        customerPhoneNo = (json['customerPhoneNo'] as List?)?.map((dynamic e) => e as num).toList(),
        customerEmail = (json['customerEmail'] as List?)?.map((dynamic e) => e as String).toList(),
        customerName = (json['customerName'] as List?)?.map((dynamic e) => e as String).toList(),
        providerPhoneNo = (json['providerPhoneNo'] as List?)?.map((dynamic e) => e as num).toList(),
        providerAddress = json['providerAddress'] as List?,
        providerId = (json['providerId'] as List?)?.map((dynamic e) => e as String).toList(),
        providerName = (json['providerName'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'paymentStatus' : paymentStatus,
    'paymentMode' : paymentMode,
    'bookingTime' : bookingTime,
    'bookingAddress' : bookingAddress,
    'grossAmount' : grossAmount,
    'serviceLists' : serviceLists?.map((e) => e.toJson()).toList(),
    'bookingId' : bookingId,
    'customerId' : customerId,
    'customerPhoneNo' : customerPhoneNo,
    'customerEmail' : customerEmail,
    'customerName' : customerName,
    'providerPhoneNo' : providerPhoneNo,
    'providerAddress' : providerAddress,
    'providerId' : providerId,
    'providerName' : providerName
  };
}

class ServiceLists {
  final String? name;
  final List<SubCategories>? subCategories;
  final num? price;

  ServiceLists({
    this.name,
    this.subCategories,
    this.price,
  });

  ServiceLists.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        subCategories = (json['subCategories'] as List?)?.map((dynamic e) => SubCategories.fromJson(e as Map<String,dynamic>)).toList(),
        price = json['price'] as num?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'subCategories' : subCategories?.map((e) => e.toJson()).toList(),
    'price' : price
  };
}

class SubCategories {
  final String? name;
  final num? price;
  final String? count;

  SubCategories({
    this.name,
    this.price,
    this.count,
  });

  SubCategories.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        price = json['price'] as num?,
        count = json['count'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'price' : price,
    'count' : count
  };
}
