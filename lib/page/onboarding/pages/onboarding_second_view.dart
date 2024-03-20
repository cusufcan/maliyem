import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/widget/custom/onboarding/onboarding_text_view.dart';

class OnboardingSecondView extends StatelessWidget {
  const OnboardingSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: BaseSize.xLg,
              horizontal: BaseSize.sm,
            ),
            child: Image.asset('assets/onboarding/2.png'),
          ),
          OnboardingTextView(BaseString.onboardingStrings[1]),
        ],
      ),
    );
  }
}
