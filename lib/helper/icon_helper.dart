import 'package:flutter/material.dart';

import '../constant/index.dart';

Icon getIcon(double money) {
  if (money > 0) return BaseIcon.income;
  return BaseIcon.expense;
}

Icon getIconWhite(double money) {
  if (money > 0) return BaseIcon.incomeWhite;
  return BaseIcon.expenseWhite;
}
