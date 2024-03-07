import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_floating_action_button.dart';

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
