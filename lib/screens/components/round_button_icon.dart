import 'package:flutter/material.dart';
import 'package:maven_class/utils/config.dart';

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({required this.icon, required this.onPress, required this.iconSize});

  final IconData icon;
  VoidCallback onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      elevation: 6.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(iconSize*0.2)),
      fillColor: primaryColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize * 0.8,
      ),
    );
  }
}