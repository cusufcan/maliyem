import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class CategoriesTileNameText extends StatelessWidget {
  const CategoriesTileNameText({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      name,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: BaseColor.black,
          ),
      alignment: Alignment.centerLeft,
    );
  }
}
