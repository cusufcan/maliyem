import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class BaseChip extends StatelessWidget {
  const BaseChip({
    super.key,
    required this.text,
    this.color = BaseColor.white,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BaseSize.lg),
      ),
      side: BorderSide.none,
      label: BaseText(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: getTextColor(color),
            ),
      ),
    );
  }
}
