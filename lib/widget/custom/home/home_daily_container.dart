import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:provider/provider.dart';

class HomeDailyContainer extends StatelessWidget {
  const HomeDailyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Consumer<UserModel>(
        builder: (context, value, child) {
          final money = value.user.monthlyIncome - value.user.monthlyExpense;
          return BaseText(
            '${BaseString.cashflow}: ${formatNumber(num: money)} ${BaseString.tl}',
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: getColor(money),
                ),
          );
        },
      ),
    );
  }
}
