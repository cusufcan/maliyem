import 'package:flutter/material.dart';

import '../../base/index.dart';

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
          ),
      alignment: Alignment.centerLeft,
    );
  }
}
