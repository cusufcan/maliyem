import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_padding.dart';
import 'package:gelir_gider_takibi/constant/base_physics.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/graph/graph_appbar.dart';

class GraphView extends StatelessWidget {
  GraphView({
    super.key,
    required this.user,
  });

  final User user;

  final List<double> amounts = [];

  void _setAmounts() {
    for (int i = 0; i < user.categories.length; i++) {
      amounts.add(0);
      for (var change in user.changes) {
        if (change.category == user.categories[i].name &&
            !change.isIncome &&
            DateTime.parse(change.date).month == DateTime.now().month) {
          amounts[i] += change.amount;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _setAmounts();
    return Scaffold(
      appBar: const GraphAppBar(),
      body: SafeArea(
        child: ListView.builder(
          padding: BasePadding.home,
          physics: BasePhysics.base,
          itemCount: user.categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: BaseSize.sm,
              ),
              child: BaseContainer(
                  color: BaseColor.expense,
                  gradient: getGradient(getColor(-10)),
                  padding: const EdgeInsets.all(BaseSize.med),
                  child: Column(
                    children: [
                      BaseText(
                        user.categories[index].name,
                        alignment: Alignment.centerLeft,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: BaseColor.white,
                                ),
                      ),
                      BaseText(
                        amounts[index].abs().toString(),
                        alignment: Alignment.centerLeft,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: BaseColor.white,
                            ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
