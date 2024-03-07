import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_padding.dart';
import 'package:gelir_gider_takibi/constant/base_physics.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/graph/graph_appbar.dart';

part 'graph_view_model.dart';

class GraphView extends StatefulWidget {
  const GraphView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends _GraphViewModel {
  @override
  Widget build(BuildContext context) {
    _setAmounts();
    return Scaffold(
      appBar: const GraphAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // graph month
            Container(
              padding: BasePadding.home,
              child: BaseContainer(
                padding: const EdgeInsets.all(BaseSize.sm),
                color: BaseColor.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_outlined),
                      onPressed: () {
                        _changeDate(false);
                      },
                    ),
                    BaseText(
                      '${BaseString.months[showDate.month - 1]} ${showDate.year}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      onPressed: () {
                        _changeDate(true);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // graph list
            ListView.builder(
              padding: BasePadding.home,
              physics: BasePhysics.base,
              shrinkWrap: true,
              itemCount: _categoryByAmountsMap.length,
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
                            _categoryByAmountsMap.keys.elementAt(index).name,
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: BaseColor.white,
                                ),
                          ),
                          BaseText(
                            _categoryByAmountsMap.values
                                .elementAt(index)
                                .abs()
                                .toString(),
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: BaseColor.white,
                                ),
                          ),
                        ],
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
