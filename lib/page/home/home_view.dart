import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

import '../../constant/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/home/index.dart';

part 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.user,
    required this.sharedManager,
  });

  final SharedManager sharedManager;
  final User user;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends _HomeViewModel {
  @override
  Widget build(BuildContext context) {
    _setLists();
    _setUserSettings();
    _saveData();
    return Scaffold(
      appBar: HomeAppBar(user: widget.user),
      body: SingleChildScrollView(
        padding: BasePadding.home,
        physics: BasePhysics.base,
        key: BaseKey.home,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeSummaryContainer(money: widget.user.balance),
            const BaseHeightBox(),
            HomeMonthlyContainer(
              income: widget.user.monthlyIncome,
              expense: widget.user.monthlyExpense,
            ),
            const BaseHeightBox(),
            Visibility(
              visible: widget.user.balance != BaseSize.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeDailyContainer(
                    money:
                        widget.user.monthlyIncome + widget.user.monthlyExpense,
                  ),
                  const BaseHeightBox(height: BaseSize.sm),
                ],
              ),
            ),
            const BaseDivider(),
            const BaseHeightBox(height: BaseSize.sm),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                List<Change> tempChanges = [];
                for (var i = 0; i < widget.user.changes.length; i++) {
                  if (dates.elementAt(index) ==
                      DateTime.parse(widget.user.changes[i].date)) {
                    tempChanges.insert(0, widget.user.changes[i]);
                  }
                }
                return HomeDailyDetailedContainer(
                  user: widget.user,
                  changes: tempChanges,
                  onTap: _openEditDialog,
                  onDelete: _openDeleteDialog,
                );
              },
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
          ],
        ),
      ),
    );
  }
}
