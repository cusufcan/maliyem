import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:pie_chart/pie_chart.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({
    super.key,
    required this.changeDate,
    required this.showDate,
    required this.categoryByAmountsMap,
  });

  final void Function(bool isForward) changeDate;
  final DateTime showDate;
  final Map<String, double> categoryByAmountsMap;

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget empty = const BaseText(
      BaseString.noData,
      style: TextStyle(color: Colors.grey),
    );

    if (widget.categoryByAmountsMap.isEmpty) {
      return empty;
    }

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
                    widget.changeDate(false);
                  },
                ),
                Expanded(
                  child: BaseText(
                    '${BaseString.months[widget.showDate.month - 1]} ${widget.showDate.year}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    widget.changeDate(true);
                  },
                ),
              ],
            ),
          ),
        ),
        const BaseHeightBox(),
        if (widget.categoryByAmountsMap.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: PieChart(
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValueBackground: true,
                  decimalPlaces: 1,
                ),
                legendOptions: const LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                ),
                dataMap: widget.categoryByAmountsMap,
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
