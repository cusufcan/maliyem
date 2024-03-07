import 'package:flutter/material.dart';

import '../constant/index.dart';
import '../model/index.dart';

Color getColor(double money) {
  if (money > 0) {
    return BaseColor.income;
  } else if (money < 0) {
    return BaseColor.expense;
  } else {
    return BaseColor.neutral;
  }
}

Gradient getGradient(Color color, {bool reverse = false}) {
  return LinearGradient(
    begin: reverse ? Alignment.centerRight : Alignment.centerLeft,
    end: reverse ? Alignment.centerLeft : Alignment.centerRight,
    colors: [
      color,
      color.withOpacity(0.7),
      color.withOpacity(0.4),
      color.withOpacity(0.2),
    ],
  );
}

String colorToString(Color color) {
  return color.value.toString();
}

Color stringToColor(String color) {
  return Color(int.parse(color));
}

Color getTextColor(Color color) {
  return color.computeLuminance() > 0.5 ? BaseColor.black : BaseColor.white;
}

int findColorIndex(Account account) {
  for (int i = 0; i < BaseColor.colors.length; i++) {
    if (account.color == colorToString(BaseColor.colors[i])) {
      return i;
    }
  }
  return 0;
}
