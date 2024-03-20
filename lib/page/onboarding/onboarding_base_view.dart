import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/page/onboarding/pages/index.dart';
import 'package:gelir_gider_takibi/service/provider/onboarding_model.dart';
import 'package:gelir_gider_takibi/widget/custom/onboarding/onboarding_dots_view.dart';
import 'package:provider/provider.dart';

class OnboardingBaseView extends StatefulWidget {
  const OnboardingBaseView({super.key});

  @override
  State<OnboardingBaseView> createState() => _OnboardingBaseViewState();
}

class _OnboardingBaseViewState extends State<OnboardingBaseView> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> pages = [
    const OnboardingFirstView(),
    const OnboardingSecondView(),
    const OnboardingThirdView(),
    const OnboardingLastView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              BaseColor.income,
              BaseColor.inactive,
              BaseColor.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Consumer<OnboardingModel>(
                builder: (context, model, child) {
                  return PageView(
                    controller: pageController,
                    onPageChanged: (index) => model.onPageChanged(
                      index,
                      pageController,
                    ),
                    children: pages,
                  );
                },
              ),
              OnboardingDotsView(pageController: pageController),
            ],
          ),
        ),
      ),
    );
  }
}
