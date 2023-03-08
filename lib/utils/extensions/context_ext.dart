import 'package:flutter/material.dart';
import 'package:maven_class/locale/base_language.dart';


extension ContextExt on BuildContext {
  Languages get translate => Languages.of(this);
}
