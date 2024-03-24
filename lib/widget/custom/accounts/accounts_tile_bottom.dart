import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import 'index.dart';

class AccountsTileBottom extends StatelessWidget {
  const AccountsTileBottom({
    super.key,
    required this.monthlyIncome,
    required this.monthlyExpense,
  });

  final double monthlyIncome;
  final double monthlyExpense;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(BaseSize.sm),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: BaseSize.semiMed,
            horizontal: BaseSize.semiLg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountsTileMonthlyBox(
                title: BaseString.monthlyIncome,
                amount: monthlyIncome,
              ),
              const VerticalDivider(),
              AccountsTileMonthlyBox(
                title: BaseString.monthlyExpense,
                amount: monthlyExpense,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
