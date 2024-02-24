import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/change.dart';

class User {
  String name;
  double balance;
  double monthlyIncome;
  double monthlyExpense;
  List<Account> accounts;
  List<Category> categories;
  List<Change> changes;

  User({
    required this.name,
    required this.balance,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.accounts,
    required this.categories,
    required this.changes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'balance': balance,
      'monthlyIncome': monthlyIncome,
      'monthlyExpense': monthlyExpense,
      'accounts': List<dynamic>.from(
        accounts.map((e) => e.toJson()),
      ),
      'categories': List<dynamic>.from(
        categories.map((e) => e.toJson()),
      ),
      'changes': List<dynamic>.from(
        changes.map((e) => e.toJson()),
      ),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      balance: json['balance'] as double,
      monthlyIncome: json['monthlyIncome'] as double,
      monthlyExpense: json['monthlyExpense'] as double,
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      changes: (json['changes'] as List<dynamic>)
          .map((e) => Change.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() =>
      "Account(name: $name, balance: $balance, monthlyIncome: $monthlyIncome, monthlyExpense: $monthlyExpense, accounts: $accounts, categories: $categories, changes: $changes)";
}
