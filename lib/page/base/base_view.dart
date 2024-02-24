import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/change.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/page/accounts/accounts_view.dart';
import 'package:gelir_gider_takibi/page/home/home_view.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:gelir_gider_takibi/widget/base/base_bottombar.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_appbar.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_fab.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_appbar.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_bottom_sheet.dart.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_fab.dart';

part 'base_view_model.dart';

class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
    required this.sharedManager,
    required this.user,
  });

  final SharedManager sharedManager;
  final User user;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends _BaseViewModel {
  @override
  Widget build(BuildContext context) {
    pages = [
      HomeView(
        user: widget.user,
        sharedManager: widget.sharedManager,
      ),
      AccountsView(
        user: widget.user,
        accounts: widget.user.accounts,
        sharedManager: widget.sharedManager,
      ),
    ];
    fabs = [
      HomeFab(
        addExpense: () => _showHomeSheet(false),
        addIncome: () => _showHomeSheet(true),
      ),
      AccountsFab(
        addAccount: () => _showAccountsSheet(),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBars[active],
      floatingActionButton: fabs[active],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BaseBottomBar(onTap: _changePage, active: active),
      body: pages[active],
    );
  }
}
