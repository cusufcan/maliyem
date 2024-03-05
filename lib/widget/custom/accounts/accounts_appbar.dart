import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/page/categories/categories_view.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class AccountsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountsAppBar({
    super.key,
    required this.sharedManager,
    required this.user,
    required this.categories,
  });

  final SharedManager sharedManager;
  final User user;
  final List<Category> categories;

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
          return CategoriesView(
            categories: categories,
            user: user,
            sharedManager: sharedManager,
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
