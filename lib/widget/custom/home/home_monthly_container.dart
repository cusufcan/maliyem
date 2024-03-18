import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_monthly_box.dart';
import 'package:provider/provider.dart';

class HomeMonthlyContainer extends StatelessWidget {
  const HomeMonthlyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Consumer<UserModel>(
            builder: (context, value, child) {
              return HomeMonthlyBox(
                color: BaseColor.income,
                title: BaseString.income,
                money: value.user.monthlyIncome,
              );
            },
          ),
        ),
        const BaseWidthBox(),
        Expanded(
          child: Consumer<UserModel>(
            builder: (context, value, child) {
              return HomeMonthlyBox(
                color: BaseColor.expense,
                title: BaseString.expense,
                money: value.user.monthlyExpense,
              );
            },
          ),
        ),
      ],
    );
  }
}
