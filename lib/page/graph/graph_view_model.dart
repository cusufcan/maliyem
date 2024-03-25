part of 'graph_view.dart';

abstract class _GraphViewModel extends State<GraphView> {
  final Map<String, double> _categoryByExpenseAmountsMap = {};
  final Map<String, double> _categoryByIncomeAmountsMap = {};

  DateTime _expenseShowDate = DateTime.now();
  DateTime _incomeShowDate = DateTime.now();

  void _setExpenseAmounts(User user) {
    for (var category in user.categories!) {
      double tempAmount = 0.0;
      for (var change in user.changes!) {
        if (change.category == category.name &&
            !change.isIncome &&
            DateTime.parse(change.date).month == _expenseShowDate.month &&
            DateTime.parse(change.date).year == _expenseShowDate.year) {
          tempAmount += change.amount;
        }
      }
      _categoryByExpenseAmountsMap[category.name] = -tempAmount;
    }
    _categoryByExpenseAmountsMap.removeWhere(
      (key, value) => value == 0,
    );

    _sortExpenseMapByAmounts();
  }

  void _sortExpenseMapByAmounts() {
    List<MapEntry<String, double>> sortedEntries =
        _categoryByExpenseAmountsMap.entries.toList();
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    _categoryByExpenseAmountsMap.clear();
    for (var entry in sortedEntries) {
      _categoryByExpenseAmountsMap[entry.key] = entry.value;
    }
  }

  void _changeExpenseDate(bool isForward) {
    if (isForward) {
      if (DateTime.now().month == _expenseShowDate.month &&
          DateTime.now().year == _expenseShowDate.year - 1) return;
      _expenseShowDate = DateTime(_expenseShowDate.year,
          _expenseShowDate.month + 1, _expenseShowDate.day);
    } else {
      if (DateTime.now().month == _expenseShowDate.month &&
          DateTime.now().year == _expenseShowDate.year + 1) return;
      _expenseShowDate = DateTime(_expenseShowDate.year,
          _expenseShowDate.month - 1, _expenseShowDate.day);
    }

    setState(() {});
  }

  void _setIncomeAmounts(User user) {
    for (var category in user.categories!) {
      double tempAmount = 0.0;
      for (var change in user.changes!) {
        if (change.category == category.name &&
            change.isIncome &&
            DateTime.parse(change.date).month == _incomeShowDate.month &&
            DateTime.parse(change.date).year == _incomeShowDate.year) {
          tempAmount += change.amount;
        }
      }
      _categoryByIncomeAmountsMap[category.name] = tempAmount;
    }
    _categoryByIncomeAmountsMap.removeWhere(
      (key, value) => value == 0,
    );

    _sortIncomeMapByAmounts();
  }

  void _sortIncomeMapByAmounts() {
    List<MapEntry<String, double>> sortedEntries =
        _categoryByIncomeAmountsMap.entries.toList();
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    _categoryByIncomeAmountsMap.clear();
    for (var entry in sortedEntries) {
      _categoryByIncomeAmountsMap[entry.key] = entry.value;
    }
  }

  void _changeIncomeDate(bool isForward) {
    if (isForward) {
      if (DateTime.now().month == _incomeShowDate.month &&
          DateTime.now().year == _incomeShowDate.year - 1) return;
      _incomeShowDate = DateTime(
          _incomeShowDate.year, _incomeShowDate.month + 1, _incomeShowDate.day);
    } else {
      if (DateTime.now().month == _incomeShowDate.month &&
          DateTime.now().year == _incomeShowDate.year + 1) return;
      _incomeShowDate = DateTime(
          _incomeShowDate.year, _incomeShowDate.month - 1, _incomeShowDate.day);
    }

    setState(() {});
  }
}
