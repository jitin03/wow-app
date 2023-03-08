// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// Welcome profileEmailFromJson(String str) => Welcome.fromJson(json.decode(str));
// List<ProviderDetail> profileEmailFromJson(String str) =>
//     List<ProviderDetail>.from(json.decode(str).map((x) => ProviderDetail.fromJson(x)));
// String welcomeToJson(ProviderDetail data) => json.encode(data.toJson());

ProviderDetail profileEmailFromJson(String str) => ProviderDetail.fromJson(json.decode(str));

String welcomeToJson(ProviderDetail data) => json.encode(data.toJson());

class ProviderDetail {
  ProviderDetail({
    this.id,
    this.serviceLists,
    this.name,
    this.phonenumber,
    this.email,
    this.address,
  });

  String? id;
  List<ServiceList>? serviceLists;
  String? name;
  int? phonenumber;
  String? email;
  List<Address>? address;

  factory ProviderDetail.fromJson(Map<String, dynamic> json) => ProviderDetail(
        id: json["id"],
        serviceLists: json["serviceLists"] == null
            ? []
            : List<ServiceList>.from(
                json["serviceLists"]!.map((x) => ServiceList.fromJson(x))),
        name: json["name"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceLists": serviceLists == null
            ? []
            : List<dynamic>.from(serviceLists!.map((x) => x.toJson())),
        "name": name,
        "phonenumber": phonenumber,
        "email": email,
        "address": address == null
            ? []
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
  dynamic pincode;
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
        subCategory: json["subCategory"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategory"]!.map((x) => SubCategory.fromJson(x))),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subCategory": subCategory == null
            ? []
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
