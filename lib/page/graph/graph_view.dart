import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/custom/graph/graph_page.dart';
import 'package:provider/provider.dart';

import '../../model/index.dart';
import '../../widget/custom/graph/index.dart';

part 'graph_view_model.dart';

class GraphView extends StatefulWidget {
  const GraphView({
    super.key,
  });

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends _GraphViewModel
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // gelir
      Consumer<UserModel>(
        builder: (context, value, child) {
          _setIncomeAmounts(value.user);
          return GraphPage(
            changeDate: _changeIncomeDate,
            showDate: _incomeShowDate,
            categoryByAmountsMap: _categoryByIncomeAmountsMap,
          );
        },
      ),
      // gider
      Consumer<UserModel>(
        builder: (context, value, child) {
          _setExpenseAmounts(value.user);
          return GraphPage(
            changeDate: _changeExpenseDate,
            showDate: _expenseShowDate,
            categoryByAmountsMap: _categoryByExpenseAmountsMap,
          );
        },
      ),
    ];
    return Scaffold(
      appBar: GraphAppBar(
        tabController: _tabController,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(
              milliseconds: BaseSize.animationSlow.toInt(),
            ),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) => _tabController.animateTo(value),
        children: pages,
      ),
    );
  }
}
