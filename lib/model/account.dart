import 'package:gelir_gider_takibi/model/name.dart';

class Account extends Name {
  double balance;
  double monthlyIncome;
  double monthlyExpense;
  String color;

  Account({
    required String name,
    required this.balance,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.color,
  }) : super(name: name);

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
  String toString() => "Account(name: $name)";
}
