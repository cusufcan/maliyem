import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';

class OnboardingDotView extends StatelessWidget {
  const OnboardingDotView({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BaseSize.xSm,
      ),
      child: Container(
        width: BaseSize.semiMed,
        height: BaseSize.semiMed,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
