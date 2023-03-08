// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/screens/components/round_button_icon.dart';
import 'package:maven_class/screens/provider/laundry_generate_bill.dart';

import '../../provider/data_provider.dart';

class CustomStepper extends ConsumerStatefulWidget {
  CustomStepper({
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.value,



  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomStepperState();



}

class _CustomStepperState extends ConsumerState<CustomStepper> {

  @override
  Widget build(BuildContext context) {
    // final serviceCartData = ref.watch(cartProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedIconButton(
          icon: Icons.remove,
          iconSize: widget.iconSize,
          onPress: () {
            setState(
              () {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;
                 // ref.read(cartProvider.notifier).updateQuantity(widget.value);
                // widget.quantity.notifyListeners();
              },
            );
            // ref.read(cartProvider.notifier).updateQuantity(widget.value);
          },
        ),
        Container(
          width: widget.iconSize,
          child: Text(
            '${widget.value}',
            style: TextStyle(
              fontSize: widget.iconSize * 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        RoundedIconButton(
          icon: Icons.add,
          iconSize: widget.iconSize,
          onPress: () {
            setState(() {
              widget.value = widget.value == widget.upperLimit
                  ? widget.upperLimit
                  : widget.value += widget.stepValue;

            });
            print(widget.value);
            // ref.read(cartProvider.notifier).updateQuantity(widget.value);
          },
        ),
      ],
    );
  }
}
