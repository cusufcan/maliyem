import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';

class BaseModel extends ChangeNotifier {
  final PageController pageController = PageController();

  int activePage = 0;

  void changePage(int index) {
    activePage = index;

    notifyListeners();
  }

  void onItemTapped(int index) {
    activePage = index;
    pageController.animateToPage(
      index,
      duration: Duration(
        milliseconds: BaseSize.animationSlow.toInt(),
      ),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }
}
