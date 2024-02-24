import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_tile_bottom.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_tile_top.dart';

class AccountsListTile extends StatelessWidget {
  const AccountsListTile({
    super.key,
    required this.account,
    this.onTap,
    required this.onDelete,
  });

  final Account account;
  final void Function()? onTap;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseContainer(
          onTap: onTap,
          color: stringToColor(account.color),
          padding: EdgeInsets.zero,
          radius: BaseSize.med,
          child: Column(
            children: [
              AccountsTileTop(
                name: account.name,
                balance: account.balance,
                onDelete: onDelete,
              ),
              AccounstTileBottom(
                monthlyIncome: account.monthlyIncome,
                monthlyExpense: account.monthlyExpense,
              ),
            ],
          ),
        ),
        const BaseHeightBox(),
      ],
    );
  }
}
