import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/accounts/accounts_view.dart';
import 'package:gelir_gider_takibi/page/home/home_view.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

import '../../constant/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/accounts/index.dart';
import '../../widget/custom/home/index.dart';

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
      floatingActionButton: fabs[active],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BaseBottomBar(onTap: _changePage, active: active),
      body: pages[active],
    );
  }
}
