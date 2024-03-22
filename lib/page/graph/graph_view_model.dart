part of 'graph_view.dart';

abstract class _GraphViewModel extends State<GraphView> {
  final Map<String, double> _categoryByAmountsMap = {};

  DateTime showDate = DateTime.now();

  void _setAmounts(User user) {
    for (var category in user.categories!) {
      double tempAmount = 0.0;
      for (var change in user.changes!) {
        if (change.category == category.name &&
            !change.isIncome &&
            DateTime.parse(change.date).month == showDate.month &&
            DateTime.parse(change.date).year == showDate.year) {
          tempAmount += change.amount;
        }
      }
      _categoryByAmountsMap[category.name] = -tempAmount;
    }
    _categoryByAmountsMap.removeWhere(
      (key, value) => value == 0,
    );

    _sortMapByAmounts();
  }

  void _sortMapByAmounts() {
    List<MapEntry<String, double>> sortedEntries =
        _categoryByAmountsMap.entries.toList();
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    _categoryByAmountsMap.clear();
    for (var entry in sortedEntries) {
      _categoryByAmountsMap[entry.key] = entry.value;
    }
  }

  void _changeDate(bool isForward) {
    if (isForward) {
      if (DateTime.now().month == showDate.month &&
          DateTime.now().year == showDate.year - 1) return;
      showDate = DateTime(showDate.year, showDate.month + 1, showDate.day);
    } else {
      if (DateTime.now().month == showDate.month &&
          DateTime.now().year == showDate.year + 1) return;
      showDate = DateTime(showDate.year, showDate.month - 1, showDate.day);
    }

    setState(() {});
  }
}
