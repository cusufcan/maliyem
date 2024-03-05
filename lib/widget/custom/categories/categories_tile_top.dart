import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';
import 'package:gelir_gider_takibi/widget/custom/categories/categories_tile_name_text.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_action_chip.dart';

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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BaseSize.med),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: BaseSize.med,
          horizontal: BaseSize.semiLg,
        ),
        child: Row(
          children: [
            Expanded(child: CategoriesTileNameText(name: name)),
            const BaseWidthBox(),
            CustomActionChip(
              text: BaseString.delete,
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
