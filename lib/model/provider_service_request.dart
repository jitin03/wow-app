// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProviderServiceRequest welcomeFromJson(String str) => ProviderServiceRequest.fromJson(json.decode(str));

String welcomeToJson(ProviderServiceRequest data) => json.encode(data.toJson());

class ProviderServiceRequest {
  ProviderServiceRequest({
    required this.serviceLists,
  });

  List<ServiceList> serviceLists;

  factory ProviderServiceRequest.fromJson(Map<String, dynamic> json) => ProviderServiceRequest(
    serviceLists: List<ServiceList>.from(json["serviceLists"].map((x) => ServiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serviceLists": List<dynamic>.from(serviceLists.map((x) => x.toJson())),
  };
}

class ServiceList {
  ServiceList({
    required this.name,
    required this.price,
    required this.subCategory,
  });

  String name;
  double price;
  List<SubCategory> subCategory;

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
    name: json["name"],
    price: json["price"],
    subCategory: List<SubCategory>.from(json["subCategory"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    required this.name,
    required this.price,
  });

  String name;
  double price;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}
