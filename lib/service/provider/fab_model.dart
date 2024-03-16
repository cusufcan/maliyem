import 'package:flutter/material.dart';

class FabModel extends ChangeNotifier {
  bool isFabOpen = false;

  void changeFabOpen() {
    isFabOpen = !isFabOpen;
    notifyListeners();
  }

  void closeFab() {
    isFabOpen = false;
    notifyListeners();
  }
}
