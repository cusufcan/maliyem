import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/categories/categories_view.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';

class AccountsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountsAppBar({
    super.key,
  });

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
      actions: [
        IconButton(
          icon: BaseIcon.category,
          tooltip: BaseString.categories,
          onPressed: () => _goToCategoriesPage(context),
        ),
      ],
    );
  }

  void _goToCategoriesPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, anim, secondAnim) {
          return const CategoriesView();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
