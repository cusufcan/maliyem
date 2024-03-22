import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:provider/provider.dart';

class SettingsModel extends ChangeNotifier {
  bool isDarkMode = false;

  void changeTheme(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  void clearAllData(BuildContext context, SharedManager manager) {
    manager.clear(SharedEnum.save);
    Provider.of<UserModel>(context, listen: false).clearUser();
    notifyListeners();
  }
}
