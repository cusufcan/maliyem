import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/accounts/accounts_view.dart';
import 'package:gelir_gider_takibi/page/home/home_view.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/custom/base/base_appbar.dart';
import 'package:gelir_gider_takibi/widget/custom/transfer/transfer_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/accounts/index.dart';
import '../../widget/custom/home/index.dart';

part 'base_view_model.dart';

class BaseView extends StatefulWidget {
  const BaseView({
    super.key,
  });

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends _BaseViewModel {
  @override
  Widget build(BuildContext context) {
    pages = [
      const HomeView(),
      const AccountsView(),
    ];
    fabs = [
      HomeFab(
        addExpense: () => _showHomeSheet(false),
        addIncome: () => _showHomeSheet(true),
        addTransfer: () => _showTransferSheet(),
      ),
      AccountsFab(
        addAccount: () => _showAccountsSheet(),
      ),
    ];

    return Consumer<BaseModel>(
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: fabs[value.activePage],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BaseBottomBar(
            onTap: value.onItemTapped,
            active: value.activePage,
          ),
          appBar: const BaseAppBar(),
          body: PageView(
            controller: value.pageController,
            onPageChanged: value.changePage,
            children: pages,
          ),
        );
      },
    );
  }
}
