import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:provider/provider.dart';

class SettingsModel extends ChangeNotifier {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  void clearAllData(BuildContext context, SharedManager manager) {
    manager.clear(SharedEnum.save);
    Provider.of<UserModel>(context, listen: false).clearUser();

    notifyListeners();
  }

  void initUserName(BuildContext context) {
    controller.text = Provider.of<UserModel>(
      context,
      listen: false,
    ).user.name;

    notifyListeners();
  }

  void iconOnClick(BuildContext context) {
    if (!focusNode.hasFocus) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      changeUserName(context);
    }

    notifyListeners();
  }

  void clearFocus(BuildContext context) {
    if (focusNode.hasFocus) focusNode.unfocus();

    notifyListeners();
  }

  void addFocus() {
    if (!focusNode.hasFocus) focusNode.requestFocus();

    notifyListeners();
  }

  void changeUserName(BuildContext context) {
    if (controller.text.isNotEmpty) {
      Provider.of<UserModel>(
        context,
        listen: false,
      ).changeUserName(
        controller.text.trim(),
      );
    }
  }
}
