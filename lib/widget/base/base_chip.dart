import 'package:flutter/material.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import 'index.dart';

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
        borderRadius: BorderRadius.circular(BaseSize.sm),
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
