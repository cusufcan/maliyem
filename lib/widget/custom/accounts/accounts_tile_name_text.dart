import 'package:flutter/material.dart';

import '../../base/index.dart';

class AccountsTileNameText extends StatelessWidget {
  const AccountsTileNameText({
    super.key,
    required this.name,
    required this.textColor,
  });

  final String name;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      name,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
      alignment: Alignment.centerLeft,
    );
  }
}
