import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class AccountsTileMonthlyBox extends StatelessWidget {
  const AccountsTileMonthlyBox({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseText(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        BaseText(
          '${formatNumber(num: amount, short: true).toUpperCase()} ${BaseString.tl}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
