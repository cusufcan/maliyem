import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/helper/icon_helper.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_chip.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_action_chip.dart';

class HomeDailyTile extends StatelessWidget {
  const HomeDailyTile({
    super.key,
    this.money = 0,
    required this.account,
    required this.color,
    required this.category,
    this.onLongPress,
    this.onDelete,
  });

  final String account;
  final String color;
  final String category;
  final double money;
  final void Function()? onLongPress;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BaseSize.semiMed),
      child: BaseContainer(
        onLongPress: onLongPress,
        padding: const EdgeInsets.symmetric(
          horizontal: BaseSize.med,
          vertical: BaseSize.semiMed,
        ),
        color: getColor(money).withOpacity(0.7),
        gradient: getGradient(getColor(money)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: BaseChip(
                    text: account,
                    color: stringToColor(color),
                  ),
                ),
                const BaseWidthBox(width: BaseSize.semiMed),
                Expanded(
                  child: BaseChip(
                    text: category,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: CustomActionChip(
                    text: BaseString.delete,
                    onTap: onDelete,
                  ),
                ),
              ],
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            Row(
              children: [
                BaseContainer(
                  circle: true,
                  color: getColor(money),
                  shadow: false,
                  child: getIconWhite(money),
                ),
                const BaseWidthBox(width: BaseSize.semiMed),
                BaseText(
                  '${formatNumber(num: money)} ${BaseString.tl}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: getColor(money),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
