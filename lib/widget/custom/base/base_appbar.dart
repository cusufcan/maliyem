import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/page/categories/categories_view.dart';
import 'package:gelir_gider_takibi/page/graph/graph_view.dart';
import 'package:gelir_gider_takibi/page/settings/settings_view.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BaseText(
        BaseString.hello,
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        IconButton(
          icon: BaseIcon.graph,
          tooltip: BaseString.graph,
          onPressed: () => _goToGraphPage(context),
        ),
        IconButton(
          icon: BaseIcon.category,
          tooltip: BaseString.categories,
          onPressed: () => _goToCategoriesPage(context),
        ),
        IconButton(
          icon: BaseIcon.settings,
          tooltip: BaseString.settings,
          onPressed: () => _goToSettingsPage(context),
        ),
      ],
    );
  }

  void _goToGraphPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, anim, secondAnim) {
          return const GraphView();
        },
      ),
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

  void _goToSettingsPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, anim, secondAnim) {
          return const SettingsView();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
