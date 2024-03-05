import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_tile_monthly_box.dart';

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
        decoration: const BoxDecoration(
          color: BaseColor.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(BaseSize.med),
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
