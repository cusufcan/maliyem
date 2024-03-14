part of 'graph_view.dart';

abstract class _GraphViewModel extends State<GraphView> {
  final Map<Category, double> _categoryByAmountsMap = {};
  double _totalAmount = 0;

  DateTime showDate = DateTime.now();

  void _setAmounts(User user) {
    _totalAmount = 0;
    for (var category in user.categories!) {
      double tempAmount = 0;
      for (var change in user.changes!) {
        if (change.category == category.name &&
            !change.isIncome &&
            DateTime.parse(change.date).month == showDate.month &&
            DateTime.parse(change.date).year == showDate.year) {
          tempAmount += change.amount;
        }
      }
      _categoryByAmountsMap[category] = tempAmount;
      _totalAmount += tempAmount.abs();
    }
    _categoryByAmountsMap.removeWhere(
      (key, value) => value == 0,
    );

    _sortMapByAmounts();

    debugPrint(_categoryByAmountsMap.toString());
  }

  void _sortMapByAmounts() {
    List<MapEntry<Category, double>> sortedEntries =
        _categoryByAmountsMap.entries.toList();
    sortedEntries.sort((a, b) => a.value.compareTo(b.value));

    _categoryByAmountsMap.clear();
    for (var entry in sortedEntries) {
      _categoryByAmountsMap[entry.key] = entry.value;
    }
  }

  void _changeDate(bool isForward) {
    if (isForward) {
      showDate = DateTime(showDate.year, showDate.month + 1, showDate.day);
    } else {
      showDate = DateTime(showDate.year, showDate.month - 1, showDate.day);
    }

    setState(() {});
  }
}
