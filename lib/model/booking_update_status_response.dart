// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingUpdateStatusResponse bookingUpdateStatusResponseFromJson(String str) =>
    BookingUpdateStatusResponse.fromJson(json.decode(str));

String bookingUpdateStatusResponseToJson(BookingUpdateStatusResponse data) =>
    json.encode(data.toJson());

class BookingUpdateStatusResponse {
  BookingUpdateStatusResponse({
    required this.customerId,
    required this.providerId,
    required this.bookingTime,
    required this.status,

    required this.paymentMode,
    required this.bookingAddress,
  });

  CustomerId customerId;
  ProviderId providerId;
  String bookingTime;
  String status;

  String paymentMode;
  String bookingAddress;

  factory BookingUpdateStatusResponse.fromJson(Map<String, dynamic> json) =>
      BookingUpdateStatusResponse(
          customerId: CustomerId.fromJson(json["customerId"]),
          providerId: ProviderId.fromJson(json["providerId"]),
          // bookingTime: DateTime.parse(json["bookingTime"]),
          bookingTime: json["bookingTime"],
          status: json["status"],

          paymentMode: json["paymentMode"],
          bookingAddress: json['bookingAddress']);

  Map<String, dynamic> toJson() => {
    "customerId": customerId.toJson(),
    "providerId": providerId.toJson(),
    // "bookingTime": bookingTime.toIso8601String(),
    "bookingTime": bookingTime.toString(),
    "status": status,

    "paymentMode": paymentMode,
    'bookingAddress': bookingAddress
  };
}

class CustomerId {
  CustomerId({
    required this.id,
    required this.name,
    required this.emailaddress,
    required this.phonenumber,
    required this.age,
    required this.gender,
    required this.address,
  });

  String id;
  String name;
  String emailaddress;
  int phonenumber;
  int age;
  String gender;
  Address address;

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["id"],
    name: json["name"],
    emailaddress: json["emailaddress"],
    phonenumber: json["phonenumber"],
    age: json["age"],
    gender: json["gender"],
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "emailaddress": emailaddress,
    "phonenumber": phonenumber,
    "age": age,
    "gender": gender,
    "address": address.toJson(),
  };
}

class Address {
  Address({
    required this.address1,
    required this.address2,
    required this.city,
    required this.pincode,
    required this.state,
  });

  String address1;
  String address2;
  String city;
  String pincode;
  String state;

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
    required this.id,
    required this.serviceLists,
    required this.phonenumber,
    required this.address,
  });

  String id;
  List<String> serviceLists;

  int phonenumber;
  List<Address> address;

  factory ProviderId.fromJson(Map<String, dynamic> json) => ProviderId(
    id: json["id"],
    serviceLists: List<String>.from(json["serviceLists"].map((x) => x)),
    phonenumber: json["phonenumber"],
    address:
    List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceLists": List<dynamic>.from(serviceLists.map((x) => x)),
    "phonenumber": phonenumber,
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
  };
}
