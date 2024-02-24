import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';

Icon getIcon(double money) {
  if (money > 0) return BaseIcon.income;
  return BaseIcon.expense;
}
