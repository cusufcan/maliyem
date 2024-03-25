import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? BaseColor.grey.shade200
          : BaseColor.grey.shade800,
    );
  }
}
