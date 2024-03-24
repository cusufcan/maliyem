import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';
import '../index.dart';
import 'index.dart';

class CategoriesTileTop extends StatelessWidget {
  const CategoriesTileTop({
    super.key,
    required this.name,
    this.onDelete,
  });

  final String name;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: BaseSize.sm,
        horizontal: BaseSize.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: CategoriesTileNameText(name: name),
          ),
          const BaseWidthBox(),
          CustomActionChip(
            text: BaseString.delete,
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}
