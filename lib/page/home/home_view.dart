import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/home/index.dart';

part 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends _HomeViewModel with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        if (Provider.of<FabModel>(context, listen: false).isFabOpen) {
          Provider.of<FabModel>(context, listen: false).closeFab();
        }
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: ListView(
          padding: BasePadding.home,
          physics: BasePhysics.base,
          children: [
            const HomeSummaryContainer(),
            const BaseHeightBox(),
            const HomeMonthlyContainer(),
            const BaseHeightBox(),
            Consumer<UserModel>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.user.balance != BaseSize.none,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeDailyContainer(),
                      BaseHeightBox(height: BaseSize.sm),
                    ],
                  ),
                );
              },
            ),
            const BaseDivider(),
            const BaseHeightBox(height: BaseSize.sm),
            Consumer<UserModel>(
              builder: (context, value, child) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.dates.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Change> tempChanges = [];
                    for (var i = 0; i < value.user.changes!.length; i++) {
                      if (value.dates.elementAt(index) ==
                          DateTime.parse(value.user.changes![i].date)) {
                        tempChanges.insert(0, value.user.changes![i]);
                      }
                    }
                    return HomeDailyDetailedContainer(
                      onTap: _openEditDialog,
                      onDelete: _openDeleteDialog,
                      privateChanges: tempChanges,
                    );
                  },
                );
              },
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
