import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';

class OnboardingModel extends ChangeNotifier {
  int currentPage = 0;

  void onPageChanged(int value, PageController controller) {
    currentPage = value;
    controller.animateToPage(
      currentPage,
      duration: Duration(
        milliseconds: BaseSize.animationSlow.toInt(),
      ),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  Color getDotColor(int index) {
    return currentPage != index ? BaseColor.inactive : BaseColor.activeGreen;
  }
}
