import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';
import '../index.dart';
import 'index.dart';

class AccountsTileTop extends StatelessWidget {
  const AccountsTileTop({
    super.key,
    required this.name,
    required this.accountColor,
    required this.balance,
    this.onDelete,
  });

  final String name;
  final Color accountColor;
  final double balance;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BaseSize.sm),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: BaseSize.md,
          horizontal: BaseSize.semiLg,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AccountsTileNameText(
                    name: name,
                    textColor: accountColor == BaseColor.white
                        ? BaseColor.text
                        : BaseColor.white,
                  ),
                ),
                const BaseWidthBox(),
                CustomActionChip(
                  text: BaseString.delete,
                  onTap: onDelete,
                  radius: BaseSize.lg,
                ),
              ],
            ),
            AccountsTileBalanceText(
              balance: balance,
              textColor: accountColor == BaseColor.white
                  ? BaseColor.text
                  : BaseColor.white,
            ),
          ],
        ),
      ),
    );
  }
}
