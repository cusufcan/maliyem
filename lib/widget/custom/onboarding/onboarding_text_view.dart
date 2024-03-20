import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';

class OnboardingTextView extends StatelessWidget {
  const OnboardingTextView(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BaseSize.xxLg,
      ),
      child: BaseText(
        text,
        maxLines: 5,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: BaseColor.text,
            ),
      ),
    );
  }
}
