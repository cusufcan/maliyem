import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_key.dart';
import 'package:gelir_gider_takibi/constant/base_padding.dart';
import 'package:gelir_gider_takibi/constant/base_physics.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/change.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:gelir_gider_takibi/widget/base/base_alert_dialog.dart';
import 'package:gelir_gider_takibi/widget/base/base_divider.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_appbar.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_daily_container.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_daily_detailed_container.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_edit_tile_dialog.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_monthly_container.dart';
import 'package:gelir_gider_takibi/widget/custom/home/home_summary_container.dart';

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
