import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/account_helper.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/helper/string_helper.dart';
import 'package:gelir_gider_takibi/model/change.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_daily_tile.dart';

class HomeDailyDetailedContainer extends StatelessWidget {
  const HomeDailyDetailedContainer({
    super.key,
    required this.user,
    required this.changes,
    required this.onTap,
    required this.onDelete,
  });

  final User user;
  final List<Change> changes;
  final void Function(Change change) onTap;
  final void Function(Change change) onDelete;

  @override
  Widget build(BuildContext context) {
    if (changes.isEmpty) return const SizedBox.shrink();
    final DateTime date = DateTime.parse(changes.first.date);
    final double money = changes.fold(
      0,
      (previousValue, element) => previousValue + (element.amount),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    '${date.day} ${BaseString.months[date.month - 1]}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const BaseHeightBox(height: BaseSize.xSm),
                  BaseText(
                    getDayString(date),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              BaseText(
                '${formatNumber(num: money)} ${BaseString.tl}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: getColor(money),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        const BaseHeightBox(height: BaseSize.semiMed),
        ListView.builder(
          itemCount: changes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return HomeDailyTile(
              account: changes[index].account,
              color: findAccount(user, changes[index].account).color,
              category: changes[index].category,
              money: changes[index].amount,
              onTap: () => onTap(changes[index]),
              onDelete: () => onDelete(changes[index]),
            );
          },
        ),
      ],
    );
  }
}
