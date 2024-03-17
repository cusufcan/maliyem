import 'package:gelir_gider_takibi/helper/color_helper.dart';

import '../constant/index.dart';
import 'index.dart';

class Account extends Name {
  double balance;
  double monthlyIncome;
  double monthlyExpense;
  String color;

  Account({
    String name = BaseString.cash,
    this.balance = BaseSize.none,
    this.monthlyIncome = BaseSize.none,
    this.monthlyExpense = BaseSize.none,
    this.color = BaseString.empty,
  }) : super(name: name) {
    if (color.isEmpty) {
      color = colorToString(BaseColor.colors.first);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'balance': balance,
      'monthlyIncome': monthlyIncome,
      'monthlyExpense': monthlyExpense,
      'color': color,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'] as String,
      balance: json['balance'] as double,
      monthlyIncome: json['monthlyIncome'] as double,
      monthlyExpense: json['monthlyExpense'] as double,
      color: json['color'] as String,
    );
  }

  @override
  String toString() =>
      "Account(name: $name), balance: $balance, monthlyIncome: $monthlyIncome, monthlyExpense: $monthlyExpense, color: $color)";
}
