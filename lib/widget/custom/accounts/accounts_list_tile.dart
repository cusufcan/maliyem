import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';
import 'index.dart';

class AccountsListTile extends StatelessWidget {
  const AccountsListTile({
    super.key,
    required this.account,
    this.onLongPress,
    required this.onDelete,
  });

  final Account account;
  final void Function()? onLongPress;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseContainer(
          onLongPress: onLongPress,
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
              AccountsTileBottom(
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
