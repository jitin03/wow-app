// To parse this JSON data, do
//
//     final ProviderProfileResponse = ProviderProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

ProviderProfileResponse provideProfileFromJson(String str) =>
    ProviderProfileResponse.fromJson(json.decode(str));

String provideProfileToJson(ProviderProfileResponse data) =>
    json.encode(data.toJson());

class ProviderProfileResponse {
  ProviderProfileResponse(
      {this.id,
      this.serviceLists,
      this.name,

      this.phonenumber,
      this.email,
      this.address,
      this.userId});

  String? id;
  List<ServiceList>? serviceLists;
  String? name;

  int? phonenumber;
  String? email;
  List<Address>? address;
  String? userId;

  factory ProviderProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProviderProfileResponse(
        id: json["id"],
        serviceLists: List<ServiceList>.from(
            json["serviceLists"].map((x) => ServiceList.fromJson(x))),
        name: json["name"],

        phonenumber: json["phonenumber"],
        email: json["email"],
        userId: json['userId'],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceLists": serviceLists == null
            ? null
            : List<dynamic>.from(serviceLists!.map((x) => x.toJson())),
        "name": name == null ? null : name,

        "phonenumber": phonenumber,
        "email": email,
        'userId': userId,
        "address": address == null
            ? null
            : List<dynamic>.from(address!.map((x) => x.toJson())),
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

class ServiceList {
  ServiceList({
    this.name,
    this.subCategory,
    this.price,
  });

  String? name;
  List<SubCategory>? subCategory;
  double? price;

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        name: json["name"],
        subCategory: List<SubCategory>.from(
            json["subCategory"].map((x) => SubCategory.fromJson(x))),
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subCategory": subCategory == null
            ? null
            : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
        "price": price,
      };
}

class SubCategory {
  SubCategory({
    this.name,
    this.price,
  });

  String? name;
  double? price;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
