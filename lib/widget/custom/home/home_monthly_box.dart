import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class HomeMonthlyBox extends StatelessWidget {
  const HomeMonthlyBox({
    super.key,
    required this.title,
    this.money = 0,
    this.color = BaseColor.white,
  });

  final String title;
  final double money;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      color: color,
      gradient: getGradient(color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            title,
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: BaseColor.white,
                ),
          ),
          BaseText(
            '${formatNumber(num: money, short: true)} ${BaseString.tl}',
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: BaseColor.white,
                ),
          ),
        ],
      ),
    );
  }
}
