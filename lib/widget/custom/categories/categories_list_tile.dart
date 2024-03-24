import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';
import 'index.dart';

class CategoriesListTile extends StatelessWidget {
  const CategoriesListTile({
    super.key,
    required this.category,
    this.onLongPress,
    required this.onDelete,
  });

  final Category category;
  final void Function()? onLongPress;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseContainer(
          onLongPress: onLongPress,
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.zero,
          radius: BaseSize.sm,
          child: CategoriesTileTop(
            name: category.name,
            onDelete: onDelete,
          ),
        ),
        const BaseHeightBox(),
      ],
    );
  }
}
