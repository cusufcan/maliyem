import 'package:flutter/material.dart';

import '../../constant/index.dart';
import '../base/index.dart';

class CustomActionChip extends StatelessWidget {
  const CustomActionChip({
    super.key,
    required this.text,
    this.onTap,
    this.radius = BaseSize.sm,
  });

  final String text;
  final double radius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      color: const MaterialStatePropertyAll(BaseColor.expense),
      onPressed: onTap,
      backgroundColor: BaseColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      side: BorderSide.none,
      label: BaseText(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: BaseColor.white,
            ),
      ),
    );
  }
}
