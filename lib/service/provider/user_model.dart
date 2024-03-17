import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/model/index.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

class UserModel extends ChangeNotifier {
  late final SharedManager _sharedManager;

  late User user = User(
    accounts: [Account()],
    categories: [Category()],
  );

  Set<DateTime> dates = {};

  Future<void> setShared() async {
    _sharedManager = SharedManager();
    await _sharedManager.init();
  }

  void getSavedUser() {
    final data = _sharedManager.getString(SharedEnum.save);
    if (data != null) {
      user = User.fromJson(json.decode(data));
      setDates();
    }
    notifyListeners();
  }

  void saveData() {
    _sharedManager.setString(
      SharedEnum.save,
      jsonEncode(user.toJson()),
    );
  }

  void setDates() {
    for (var change in user.changes ?? []) {
      dates.add(DateTime.parse(change.date));
    }

    List<DateTime> temp = dates.toList();
    temp.sort((a, b) => b.compareTo(a));
    dates = temp.toSet();
  }

  void addChange(Change change, BuildContext context) {
    user.changes?.add(change);
    setDates();

    _setUserSettings();
    _sortAccounts();
    _sortCategories();

    notifyListeners();

    saveData();
  }

  void updateChange(Change oldChange, Change newChange) {
    int index = user.changes?.indexOf(oldChange) ?? 0;
    user.changes?.remove(oldChange);
    user.changes?.insert(index, newChange);
    setDates();

    _setUserSettings();
    _sortAccounts();
    _sortCategories();

    notifyListeners();

    saveData();
  }

  void deleteChange(Change change) {
    user.changes?.remove(change);
    setDates();

    _setUserSettings();
    _sortAccounts();
    _sortCategories();

    notifyListeners();

    saveData();
  }

  void _updateAllChangesOnAccount(Account oldAccount, Account newAccount) {
    for (var change in user.changes ?? []) {
      if (change.account == oldAccount.name) {
        change.account = newAccount.name;
      }
    }
  }

  void _updateAllChangesOnCategory(Category oldCategory, Category newCategory) {
    for (var change in user.changes ?? []) {
      if (change.category == oldCategory.name) {
        change.category = newCategory.name;
      }
    }
  }

  void addAccount(Account account) {
    user.accounts?.add(account);

    //? SONRA BAKILACAK
    // user.balance += account.balance;

    notifyListeners();
    saveData();
  }

  void updateAccount(Account oldAccount, Account newAccount) {
    int index = user.accounts?.indexOf(oldAccount) ?? 0;
    user.accounts?.remove(oldAccount);
    user.accounts?.insert(index, newAccount);
    _updateAllChangesOnAccount(oldAccount, newAccount);

    notifyListeners();
    saveData();
  }

  void deleteAccount(int index) {
    user.accounts?.removeAt(index);

    notifyListeners();
    saveData();
  }

  void addCategory(Category category) {
    user.categories?.add(category);

    notifyListeners();
    saveData();
  }

  void updateCategory(Category oldCategory, Category newCategory) {
    int index = user.categories?.indexOf(oldCategory) ?? 0;
    user.categories?.remove(oldCategory);
    user.categories?.insert(index, newCategory);
    _updateAllChangesOnCategory(oldCategory, newCategory);

    notifyListeners();
  }

  void deleteCategory(int index) {
    user.categories?.removeAt(index);

    notifyListeners();
    saveData();
  }

  void _setUserSettings() {
    double tempBalance = 0;
    double tempMonthlyIncome = 0;
    double tempMonthlyExpense = 0;
    for (var change in user.changes ?? []) {
      var changeDate = DateTime.parse(change.date);
      bool isDateUp = changeDate.month == DateTime.now().month &&
          changeDate.year == DateTime.now().year;

      tempBalance += change.amount;
      tempMonthlyIncome += change.isIncome && isDateUp ? change.amount : 0;
      tempMonthlyExpense +=
          !change.isIncome && isDateUp ? change.amount.abs() : 0;
    }

    user.balance = tempBalance;
    user.monthlyIncome = tempMonthlyIncome;
    user.monthlyExpense = tempMonthlyExpense;

    // hesaplardaki degerleri duzenle
    for (var account in user.accounts ?? [Account()]) {
      double tempAccountBalance = 0;
      double tempAccountMonthlyIncome = 0;
      double tempAccountMonthlyExpense = 0;

      if (user.changes?.isEmpty ?? true) {
        account.balance = 0;
        account.monthlyIncome = 0;
        account.monthlyExpense = 0;
        break;
      }
      for (var change in user.changes ?? []) {
        var tempDate = DateTime.parse(change.date);
        bool isDateUp = tempDate.month == DateTime.now().month;

        if (change.account == account.name) {
          tempAccountBalance += change.amount;
          tempAccountMonthlyIncome +=
              change.isIncome && isDateUp ? change.amount : 0;
          tempAccountMonthlyExpense +=
              !change.isIncome && isDateUp ? change.amount : 0;
        }
      }
      account.balance = tempAccountBalance;
      account.monthlyIncome = tempAccountMonthlyIncome;
      account.monthlyExpense = tempAccountMonthlyExpense;
    }
  }

  void _sortAccounts() {
    // bu ayki tum gelir-giderleri baska bir listeye cek
    var tempChanges = user.changes?.where((element) {
      return DateTime.parse(element.date).month == DateTime.now().month;
    }).toList();

    // tum kategorilerde gez
    Map<Account, int> accountsSortedMap = {};
    for (var account in user.accounts ?? [Account()]) {
      int counter = 0;
      // yeni gelir-gider listesini gez
      for (var change in tempChanges ?? []) {
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
    user.accounts?.clear();
    accountsSortedMap.forEach((key, value) {
      user.accounts?.add(key);
    });
  }

  void _sortCategories() {
    // bu ayki tum gelir-giderleri baska bir listeye cek
    var tempChanges = user.changes?.where((element) {
      return DateTime.parse(element.date).month == DateTime.now().month;
    }).toList();

    // tum kategorilerde gez
    Map<Category, int> categoriesSortedMap = {};
    for (var category in user.categories ?? [Category()]) {
      int counter = 0;
      // yeni giderler listesini gez
      for (var change in tempChanges ?? []) {
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
    user.categories?.clear();
    categoriesSortedMap.forEach((key, value) {
      user.categories?.add(key);
    });
  }
}
