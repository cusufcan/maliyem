import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';

class CategoriesFab extends StatelessWidget {
  const CategoriesFab({
    super.key,
    required this.addCategory,
  });

  final void Function() addCategory;

  @override
  Widget build(BuildContext context) {
    return BaseFloatingActionButton(
      onPressed: addCategory,
      tooltip: BaseString.add,
      icon: BaseIcon.add,
    );
  }
}
