part of 'home_view.dart';

abstract class _HomeViewModel extends State<HomeView> {
  Set<DateTime> dates = {};

  void _setLists() {
    for (var change in widget.user.changes) {
      dates.add(DateTime.parse(change.date));
    }

    List<DateTime> temp = dates.toList();
    temp.sort((a, b) => b.compareTo(a));
    dates = temp.toSet();

    _sortCategories();
    _sortAccounts();
  }

  void _sortCategories() {
    // bu ayki tum gelir-giderleri baska bir listeye cek
    var tempChanges = widget.user.changes.where((element) {
      return DateTime.parse(element.date).month == DateTime.now().month;
    }).toList();

    // tum kategorilerde gez
    Map<Category, int> categoriesSortedMap = {};
    for (var category in widget.user.categories) {
      int counter = 0;
      // yeni giderler listesini gez
      for (var change in tempChanges) {
        // bu kategoriye uygun gelir-gider varsa sayac arttir
        if (category.name == change.category) counter++;
      }
      // kategoriye ait gelir-gider sayisini listeye ekle
      categoriesSortedMap[category] = counter;
    }

    // kategorileri gider sayisina gore sirala
    categoriesSortedMap = Map.fromEntries(
      categoriesSortedMap.entries.toList()
        ..sort((e1, e2) => e2.value.compareTo(e1.value)),
    );

    // kullanici kategorilerini yeni siralamaya gore guncelle
    widget.user.categories.clear();
    categoriesSortedMap.forEach((key, value) {
      widget.user.categories.add(key);
    });
  }

  void _sortAccounts() {
    // bu ayki tum gelir-giderleri baska bir listeye cek
    var tempChanges = widget.user.changes.where((element) {
      return DateTime.parse(element.date).month == DateTime.now().month;
    }).toList();

    // tum kategorilerde gez
    Map<Account, int> accountsSortedMap = {};
    for (var account in widget.user.accounts) {
      int counter = 0;
      // yeni gelir-gider listesini gez
      for (var change in tempChanges) {
        // bu hesaba uygun gelir-gider varsa sayac arttir
        if (account.name == change.account) counter++;
      }
      // hesaba ait gelir-gider sayisini listeye ekle
      accountsSortedMap[account] = counter;
    }

    // hesaplari gelir-gider sayisina gore sirala
    accountsSortedMap = Map.fromEntries(
      accountsSortedMap.entries.toList()
        ..sort((e1, e2) => e2.value.compareTo(e1.value)),
    );

    // kullanici hesaplarini yeni siralamaya gore guncelle
    widget.user.accounts.clear();
    accountsSortedMap.forEach((key, value) {
      widget.user.accounts.add(key);
    });
  }

  void _setUserSettings() {
    double tempBalance = 0;
    double tempMonthlyIncome = 0;
    double tempMonthlyExpense = 0;
    for (var change in widget.user.changes) {
      var tempDate = DateTime.parse(change.date);
      bool isDateUp = tempDate.month == DateTime.now().month;

      tempBalance += change.amount;
      tempMonthlyIncome += change.isIncome && isDateUp ? change.amount : 0;
      tempMonthlyExpense += !change.isIncome && isDateUp ? change.amount : 0;
    }

    widget.user.balance = tempBalance;
    widget.user.monthlyIncome = tempMonthlyIncome;
    widget.user.monthlyExpense = tempMonthlyExpense;

    // hesaplardaki degerleri duzenle
    for (var account in widget.user.accounts) {
      double tempAccountBalance = 0;
      double tempAccountMonthlyIncome = 0;
      double tempAccountMonthlyExpense = 0;
      if (widget.user.changes.isEmpty) {
        account.balance = 0;
        account.monthlyIncome = 0;
        account.monthlyExpense = 0;
        break;
      }
      for (var change in widget.user.changes) {
        var tempDate = DateTime.parse(change.date);
        bool isDateUp = tempDate.month == DateTime.now().month;

        if (change.account == account.name) {
          tempAccountBalance += change.amount;
          tempAccountMonthlyIncome +=
              change.isIncome && isDateUp ? change.amount : 0;
          tempAccountMonthlyExpense +=
              !change.isIncome && isDateUp ? change.amount : 0;
        }
        account.balance = tempAccountBalance;
        account.monthlyIncome = tempAccountMonthlyIncome;
        account.monthlyExpense = tempAccountMonthlyExpense;
      }
    }
  }

  void _saveData() {
    widget.sharedManager.setString(
      SharedEnum.save,
      jsonEncode(widget.user.toJson()),
    );
  }

  Future<void> _openEditDialog(Change change) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BaseSize.med),
          ),
          scrollable: true,
          title: BaseText(
            BaseString.edit,
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: HomeEditTileDialog(
            change: change,
            user: widget.user,
            onSave: (Change newChange) => _updateChange(
              change,
              newChange,
            ),
          ),
        );
      },
    );
  }

  void _updateChange(Change oldChange, Change newChange) {
    int index = widget.user.changes.indexOf(oldChange);
    widget.user.changes.remove(oldChange);
    widget.user.changes.insert(index, newChange);
    _setUserSettings();
    _setLists();
    setState(() {});
  }

  Future<void> _openDeleteDialog(Change change) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseAlertDialog(
          title: BaseString.delete,
          desc: BaseString.deleteDesc,
          ok: BaseString.delete,
          onPressed: () => _deleteChange(change),
        );
      },
    );
  }

  void _deleteChange(Change change) {
    widget.user.changes.remove(change);
    _setUserSettings();
    _setLists();
    Navigator.of(context).pop();
    setState(() {});
  }
}
