// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<BookingResponseModel> welcomeFromJson(String str) => List<BookingResponseModel>.from(json.decode(str).map((x) => BookingResponseModel.fromJson(x)));

String welcomeToJson(List<BookingResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingResponseModel {
  BookingResponseModel({
     this.serviceType,
     this.status,
     this.paymentMode,
     this.bookingTime,
     this.customerId,
     this.providerId,
     this.bookingId,
     this.bookingAddress,
  });

  String? serviceType;
  String? status;
  String? paymentMode;
  String? bookingTime;
  List<CustomerId>? customerId;
  List<ProviderId>? providerId;
  num? bookingId;
  String? bookingAddress;

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) => BookingResponseModel(
    serviceType: json["serviceType"],
    status: json["status"],
    paymentMode: json["paymentMode"],
    bookingTime : json["bookingTime"],
    customerId: List<CustomerId>.from(json["customerId"].map((x) => CustomerId.fromJson(x))),
    providerId: List<ProviderId>.from(json["providerId"].map((x) => ProviderId.fromJson(x))),
    bookingId: json["bookingId"],
    bookingAddress: json['bookingAddress']
  );

  Map<String, dynamic> toJson() => {
    "serviceType": serviceType,
    "status": status,
    "paymentMode": paymentMode,
    "bookingTime": bookingTime,
    "customerId": List<dynamic>.from(customerId!.map((x) => x.toJson())),
    "providerId": List<dynamic>.from(providerId!.map((x) => x.toJson())),
    "bookingId": bookingId,
    "bookingAddress":bookingAddress,
  };
}

class CustomerId {
  CustomerId({
     this.id,
     this.name,
     this.emailaddress,
     this.phonenumber,
     this.age,
     this.gender,
     this.address,
     this.customerIdClass,
  });

  String? id;
  String? name;
  String? emailaddress;
  num? phonenumber;
  num? age;
  String? gender;
  Address? address;
  String? customerIdClass;

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"],
    name: json["name"],
    emailaddress: json["emailaddress"],
    phonenumber: json["phonenumber"],
    age: json["age"],
    gender: json["gender"],
    address: Address.fromJson(json["address"]),
    customerIdClass: json["_class"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "emailaddress": emailaddress,
    "phonenumber": phonenumber,
    "age": age,
    "gender": gender,
    "address": address!.toJson(),
    "_class": customerIdClass,
  };
}

class Address {
  Address({
     this.address1,
     this.address2,
     this.city,
     this.pincode,
     this.state,
  });

  String? address1;
  String? address2;
  String? city;
  String? pincode;
  String? state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    pincode: json["pincode"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "city": city,
    "pincode": pincode,
    "state": state,
  };
}

class ProviderId {
  ProviderId({
     this.id,
     this.name,
     this.serviceLists,
     this.phonenumber,
     this.address,
     this.providerIdClass,
  });

  String? id;
  String? name;
  List<ServiceList>? serviceLists;
  num? phonenumber;
  List<Address>? address;
  String? providerIdClass;

  factory ProviderId.fromJson(Map<String, dynamic> json) => ProviderId(
    id: json["_id"],
    name: json["name"],
    serviceLists: List<ServiceList>.from(json["serviceLists"].map((x) => ServiceList.fromJson(x))),

    phonenumber: json["phonenumber"],
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    providerIdClass: json["_class"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "serviceLists": List<dynamic>.from(serviceLists!.map((x) => x.toJson())),
    "phonenumber": phonenumber,
    "address": List<dynamic>.from(address!.map((x) => x.toJson())),
    "_class": providerIdClass,
  };
}

class ServiceList {
  ServiceList({
     this.name,
     this.subCategory,
     this.price,
  });

  String? name;
  List<SubCategory>? subCategory;
  num? price;

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
    name: json["name"],
    subCategory: List<SubCategory>.from(json["subCategory"].map((x) => SubCategory.fromJson(x))),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subCategory": List<dynamic>.from(subCategory!.map((x) => x.toJson())),
    "price": price,
  };
}

class SubCategory {
  SubCategory({
     this.name,
     this.price,
  });

  String? name;
  num? price;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}


