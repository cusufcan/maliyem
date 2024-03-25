import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../base/index.dart';

class AccountsTileBalanceText extends StatelessWidget {
  const AccountsTileBalanceText({
    super.key,
    required this.balance,
    required this.textColor,
  });

  final Color textColor;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      '${formatNumber(num: balance, short: true)} ${BaseString.tl}',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
    );
  }
}
