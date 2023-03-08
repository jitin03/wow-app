// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/provider/sharedpref/preferences.dart';
import 'package:riverpod/riverpod.dart';

class Services {
  Services({
    this.name,
    this.price,
    this.quantity = 1,
  });

  Services.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];

    quantity = 1;
  }

  int? price;
  String? name;

  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    map['quantity'] = quantity;

    return map;
  }

  Services copyWith({
    int? price,
    String? name,
    int? quantity,
  }) {
    return Services(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ServicesNotifier extends StateNotifier<Services> {
  ServicesNotifier(super.state);

  void updateQuantity(int quantity) {
    state = state.copyWith(quantity: quantity);
  }
}

class ServicesListNotifier extends StateNotifier<Services> {
  List<Services> list = [];

  // ServicesListNotifier(super.state);
  ServicesListNotifier(super.state);

  void increment(int index) {
    list[index].quantity = list[index].quantity! + 1;
    print(list[0].quantity);
  }

  void decrement(int index) {
    if (list[index].quantity! > 1) {
      list[index].quantity = list[index].quantity! - 1;
    }
  }
}
