import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/service/provider/onboarding_model.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:gelir_gider_takibi/widget/custom/onboarding/onboarding_button_view.dart';
import 'package:gelir_gider_takibi/widget/custom/onboarding/onboarding_dot_view.dart';
import 'package:provider/provider.dart';

class OnboardingDotsView extends StatelessWidget {
  const OnboardingDotsView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: BaseSize.onboardingBottom,
      right: MediaQuery.of(context).size.width / 2 - 100,
      left: MediaQuery.of(context).size.width / 2 - 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<OnboardingModel>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => OnboardingDotView(
                    color: value.getDotColor(index),
                  ),
                ),
              );
            },
          ),
          const BaseHeightBox(height: BaseSize.semiMed),
          OnboardingButtonView(pageController: pageController),
        ],
      ),
    );
  }
}
