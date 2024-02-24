import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/page/base/base_view.dart';
import 'package:gelir_gider_takibi/page/splash/splash_view.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

abstract class SplashViewModel extends State<SplashView> {
  late final SharedManager _sharedManager;
  User? user;

  @override
  void initState() {
    super.initState();

    _checkFirstLogin();
  }

  Future<void> _checkFirstLogin() async {
    await _setShared();
    _getData();
    await Future.delayed(const Duration(seconds: 2));
    _goToBase();
  }

  void _goToBase() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, anim, secondAnim) => BaseView(
        user: user ??
            User(
              name: BaseString.username,
              balance: BaseSize.none,
              monthlyIncome: BaseSize.none,
              monthlyExpense: BaseSize.none,
              accounts: [
                Account(
                  name: BaseString.cash,
                  balance: BaseSize.none,
                  monthlyIncome: BaseSize.none,
                  monthlyExpense: BaseSize.none,
                  color: colorToString(BaseColor.colors.first),
                ),
              ],
              categories: [
                Category(
                  name: BaseString.general,
                ),
              ],
              changes: [],
            ),
        sharedManager: _sharedManager,
      ),
    ));
  }

  Future<void> _setShared() async {
    _sharedManager = SharedManager();
    await _sharedManager.init();
  }

  void _getData() {
    final data = _sharedManager.getString(SharedEnum.save);
    if (data != null) {
      user = User.fromJson(json.decode(data));
    }
  }
}
