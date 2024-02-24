class Change {
  String account;
  String category;
  double amount;
  String date;
  bool isIncome;

  Change({
    required this.account,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  }) {
    if (!isIncome && amount > 0) amount = -amount;
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'category': category,
      'amount': amount,
      'date': date,
      'isIncome': isIncome,
    };
  }

  factory Change.fromJson(Map<String, dynamic> json) {
    return Change(
      account: json['account'] as String,
      category: json['category'] as String,
      amount: json['amount'] as double,
      date: json['date'] as String,
      isIncome: json['isIncome'] as bool,
    );
  }

  @override
  String toString() =>
      "Change(account: $account, category: $category, amount: $amount, date: $date, isIncome: $isIncome)";
}
