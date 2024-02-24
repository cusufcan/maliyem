import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class AccountsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BaseText(
        BaseString.accounts,
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
