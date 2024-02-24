import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_tile_balance_text.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_tile_name_text.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_action_chip.dart';

class AccountsTileTop extends StatelessWidget {
  const AccountsTileTop({
    super.key,
    required this.name,
    required this.balance,
    this.onDelete,
  });

  final String name;
  final double balance;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BaseSize.med),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: BaseSize.med,
          horizontal: BaseSize.semiLg,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: AccounstTileNameText(name: name)),
                const BaseWidthBox(),
                CustomActionChip(
                  text: BaseString.delete,
                  onTap: onDelete,
                ),
              ],
            ),
            AccountsTileBalanceText(balance: balance),
          ],
        ),
      ),
    );
  }
}
