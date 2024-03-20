import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  const BaseText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.alignment = Alignment.center,
    this.textAlign,
    this.onTap,
  });

  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow overflow;
  final Alignment alignment;
  final TextAlign? textAlign;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: style ?? Theme.of(context).textTheme.bodyMedium,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
