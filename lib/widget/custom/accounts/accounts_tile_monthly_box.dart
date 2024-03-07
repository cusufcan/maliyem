import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../base/index.dart';

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
