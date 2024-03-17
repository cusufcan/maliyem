import 'package:flutter/material.dart';

class HomeDialogModel extends ChangeNotifier {
  int accountsActive = 0;
  int categoriesActive = 0;

  DateTime date = DateTime.now();

  void changeAccountActive(int index) {
    accountsActive = index;
    notifyListeners();
  }

  void changeCategoryActive(int index) {
    categoriesActive = index;
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

  void clearValues() {
    accountsActive = 0;
    categoriesActive = 0;
    date = DateTime.now();
    notifyListeners();
  }
}
