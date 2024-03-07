import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';

class GraphAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GraphAppBar({super.key});

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
