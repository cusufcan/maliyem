import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../base/index.dart';

class GraphChartBar extends StatelessWidget {
  const GraphChartBar({
    super.key,
    required this.fill,
    required this.name,
    required this.amount,
  });

  final double fill;
  final String name;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: fill > 0.3 ? fill : 0.3,
        child: BaseContainer(
          color: BaseColor.expense,
          gradient: getGradient(getColor(-10)),
          padding: const EdgeInsets.all(BaseSize.semiMed),
          child: Column(
            children: [
              BaseText(
                name,
                alignment: Alignment.centerLeft,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: BaseColor.white,
                    ),
              ),
              BaseText(
                amount,
                alignment: Alignment.centerLeft,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: BaseColor.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
