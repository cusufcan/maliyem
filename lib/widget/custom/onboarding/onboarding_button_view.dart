import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/page/base/base_view.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/service/provider/onboarding_model.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:provider/provider.dart';

class OnboardingButtonView extends StatelessWidget {
  const OnboardingButtonView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BaseSize.semiMed,
      ),
      child: Consumer<OnboardingModel>(
        builder: (context, value, child) {
          return BaseElevatedButton(
            onPressed: () {
              if (value.currentPage == 3) {
                Provider.of<UserModel>(context, listen: false).saveFirstLogin();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const BaseView();
                    },
                  ),
                );
              } else if (value.currentPage < 3) {
                value.onPageChanged(
                  value.currentPage + 1,
                  pageController,
                );
              }
            },
            text: value.currentPage == 3
                ? BaseString.onboardingStart
                : BaseString.onboardingNext,
          );
        },
      ),
    );
  }
}
