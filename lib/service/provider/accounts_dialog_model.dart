import 'package:flutter/material.dart';

class AccountsDialogModel extends ChangeNotifier {
  int active = 0;

  void changeAccountActive(int index) {
    active = index;
    notifyListeners();
  }

  void clearValues() {
    active = 0;
    notifyListeners();
  }
}
