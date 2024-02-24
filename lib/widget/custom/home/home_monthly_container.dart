import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_monthly_box.dart';

class HomeMonthlyContainer extends StatelessWidget {
  const HomeMonthlyContainer({
    super.key,
    this.income = 0,
    this.expense = 0,
  });

  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HomeMonthlyBox(
            color: BaseColor.income,
            title: BaseString.income,
            money: income,
          ),
        ),
        const BaseWidthBox(),
        Expanded(
          child: HomeMonthlyBox(
            color: BaseColor.expense,
            title: BaseString.expense,
            money: expense,
          ),
        ),
      ],
    );
  }
}
