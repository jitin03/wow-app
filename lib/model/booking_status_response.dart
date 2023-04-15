// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingStatusResponse bookingStatusResponseFromJson(String str) =>
    BookingStatusResponse.fromJson(json.decode(str));

String bookingStatusResponseToJson(BookingStatusResponse data) =>
    json.encode(data.toJson());

class BookingStatusResponse {
  BookingStatusResponse({
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
    this.customerName,
    this.customerEmail,
    this.providerId,
  });
  String? status;
  String? paymentStatus;
  String? paymentMode;
  String? bookingTime;
  String? bookingAddress;
  String? grossAmount;
  List<ServiceLists>? serviceLists;
  num? bookingId;
  List<String>? customerId;
  List<num>? customerPhoneNo;
  List<String>? customerEmail;
  List<String>? customerName;
  List<String>? providerId;

  BookingStatusResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    paymentMode = json['paymentMode'];
    bookingTime = json['bookingTime'];
    bookingAddress = json['bookingAddress'];
    grossAmount = json['grossAmount'];
    serviceLists = List.from(json['serviceLists']).map((e)=>ServiceLists.fromJson(e)).toList();
    bookingId = json['bookingId'];
    customerId = List.castFrom<dynamic, String>(json['customerId']);
    customerPhoneNo = List.castFrom<dynamic, num>(json['customerPhoneNo']);
    customerName = List.castFrom<dynamic, String>(json['customerName']);
    customerEmail = List.castFrom<dynamic, String>(json['customerEmail']);
    providerId = List.castFrom<dynamic, String>(json['providerId']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['paymentStatus'] = paymentStatus;
    _data['paymentMode'] = paymentMode;
    _data['bookingTime'] = bookingTime;
    _data['bookingAddress'] = bookingAddress;
    _data['grossAmount'] = grossAmount;
    _data['serviceLists'] = serviceLists!.map((e)=>e.toJson()).toList();
    _data['bookingId'] = bookingId;
    _data['customerId'] = customerId;
    _data['customerPhoneNo'] = customerPhoneNo;
    _data['customerEmail'] = customerEmail;
    _data['customerName'] = customerName;
    _data['providerId'] = providerId;
    return _data;
  }
}

class ServiceLists {
  ServiceLists({
    this.name,
    this.subCategories,
    this.price,
  });
  String? name;
  List<SubCategories>? subCategories;
  num? price;

  ServiceLists.fromJson(Map<String, dynamic> json){
    name = json['name'];
    subCategories = List.from(json['subCategories']).map((e)=>SubCategories.fromJson(e)).toList();
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['subCategories'] = subCategories!.map((e)=>e.toJson()).toList();
    _data['price'] = price;
    return _data;
  }
}

class SubCategories {
  SubCategories({
    this.name,
    this.price,
    this.count,
  });
  String? name;
  num? price;
  String? count;

  SubCategories.fromJson(Map<String, dynamic> json){
    name = json['name'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['price'] = price;
    _data['count'] = count;
    return _data;
  }
}