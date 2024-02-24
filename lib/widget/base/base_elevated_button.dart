import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor = BaseColor.active,
    this.textColor = BaseColor.white,
  });

  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: BaseText(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
