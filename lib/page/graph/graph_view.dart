import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:pie_chart/pie_chart.dart';
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_outlined),
                        onPressed: () {
                          _changeDate(false);
                        },
                      ),
                      Expanded(
                        child: BaseText(
                          '${BaseString.months[showDate.month - 1]} ${showDate.year}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
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
              if (_categoryByAmountsMap.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: PieChart(
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                      ),
                      dataMap: _categoryByAmountsMap,
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
