import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/custom/categories/categories_tile_top.dart';

class CategoriesListTile extends StatelessWidget {
  const CategoriesListTile({
    super.key,
    required this.category,
    this.onTap,
    required this.onDelete,
  });

  final Category category;
  final void Function()? onTap;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseContainer(
          onTap: onTap,
          color: BaseColor.white,
          padding: EdgeInsets.zero,
          radius: BaseSize.med,
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
