import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/widget/custom/graph/graph_chart_bar.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/graph/index.dart';

part 'graph_view_model.dart';

class GraphView extends StatefulWidget {
  const GraphView({
    super.key,
  });

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends _GraphViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraphAppBar(),
      body: Consumer<UserModel>(
        builder: (context, value, child) {
          _setAmounts(value.user);
          return Column(
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

              const BaseHeightBox(),

              // graph list
              Expanded(
                child: Material(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: BaseSize.med,
                    ),
                    physics: BasePhysics.base,
                    itemCount: _categoryByAmountsMap.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: GraphChartBar(
                          fill: _categoryByAmountsMap.values
                                      .elementAt(index)
                                      .abs() ==
                                  0
                              ? 0
                              : _categoryByAmountsMap.values
                                      .elementAt(index)
                                      .abs() /
                                  _totalAmount,
                          name:
                              _categoryByAmountsMap.keys.elementAt(index).name,
                          amount: _categoryByAmountsMap.values
                              .elementAt(index)
                              .abs()
                              .toString(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
