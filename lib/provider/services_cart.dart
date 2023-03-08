


import 'package:maven_class/model/service_cart.dart';
import 'package:riverpod/riverpod.dart';

class ServicesCart extends StateNotifier<List<Services>> {
  ServicesCart() : super([]);

  void addItem(Services item) {
    state = [...state, item];
  }

  // void removeItem(Services item) {
  //   state = state.where((cartItem) => cartItem.id != item.id).toList();
  // }

  // double get totalPrice => state.fold(0, (total, item) => total + (item.price * item.quantity!));
}
