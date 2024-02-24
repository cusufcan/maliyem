import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class HomeSummaryContainer extends StatelessWidget {
  const HomeSummaryContainer({
    super.key,
    this.money = 0,
  });

  final double money;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: BaseText(
        '${formatNumber(num: money, short: true)} ${BaseString.tl}',
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
