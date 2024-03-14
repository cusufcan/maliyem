import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: BaseSize.sm,
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width,
                                  minWidth: BaseSize.minWidth,
                                ),
                                child: BaseContainer(
                                  width: _categoryByAmountsMap.values
                                          .elementAt(index)
                                          .abs() /
                                      _totalAmount *
                                      MediaQuery.of(context).size.width,
                                  color: BaseColor.expense,
                                  gradient: getGradient(getColor(-10)),
                                  padding: const EdgeInsets.all(BaseSize.med),
                                  child: Column(
                                    children: [
                                      BaseText(
                                        _categoryByAmountsMap.keys
                                            .elementAt(index)
                                            .name,
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
                                  ),
                                ),
                              ),
                            ),
                          ],
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
