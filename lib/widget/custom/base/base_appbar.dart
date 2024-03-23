import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/page/categories/categories_view.dart';
import 'package:gelir_gider_takibi/page/graph/graph_view.dart';
import 'package:gelir_gider_takibi/page/settings/settings_view.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Consumer<UserModel>(
        builder: (context, userModel, child) {
          return BaseText(
            '${BaseString.hello} ${userModel.user.name}',
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          );
        },
      ),
      actions: [
        PopupMenuButton(
          tooltip: BaseString.menu,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                onTap: () => _goToGraphPage(context),
                child: const Row(
                  children: [
                    BaseIcon.graph,
                    BaseWidthBox(),
                    Text(BaseString.graph),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: () => _goToCategoriesPage(context),
                child: const Row(
                  children: [
                    BaseIcon.category,
                    BaseWidthBox(),
                    Text(BaseString.categories),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: () => _goToSettingsPage(context),
                child: const Row(
                  children: [
                    BaseIcon.settings,
                    BaseWidthBox(),
                    Text(BaseString.settings),
                  ],
                ),
              ),
            ];
          },
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
