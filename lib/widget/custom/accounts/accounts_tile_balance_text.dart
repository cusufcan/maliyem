import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class AccountsTileBalanceText extends StatelessWidget {
  const AccountsTileBalanceText({
    super.key,
    required this.balance,
  });

  final double balance;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      '${formatNumber(num: balance, short: true)} ${BaseString.tl}',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: BaseColor.white,
          ),
    );
  }
}
