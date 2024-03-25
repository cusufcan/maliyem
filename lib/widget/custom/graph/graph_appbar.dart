import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';

class GraphAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GraphAppBar({
    super.key,
    required this.tabController,
    required this.onTap,
  });

  final TabController tabController;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BaseText(
        BaseString.graph,
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      bottom: TabBar(
        controller: tabController,
        onTap: onTap,
        tabs: const [
          Tab(text: BaseString.income),
          Tab(text: BaseString.expense),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight + kToolbarHeight,
      );
}
