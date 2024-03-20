import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/constant/enum/transfer_error_enum.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
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

  bool isFirstLogin() {
    final bool isFirst = !_sharedManager.hasData(SharedEnum.first);
    return isFirst;
  }

  void saveData() {
    _sharedManager.setString(
      SharedEnum.save,
      jsonEncode(user.toJson()),
    );
  }

  void saveFirstLogin() {
    _sharedManager.setString(
      SharedEnum.first,
      BaseString.ok,
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

  //* GELIR-GIDER METODLARI

  void addChange(Change change, BuildContext context) {
    user.changes?.add(change);
    setDates();

    _updateAccountAfterChangeAdd(change);

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

    _updateAccountAfterChangeUpdate(oldChange, newChange);

    _sortAccounts();
    _sortCategories();

    notifyListeners();

    saveData();
  }

  void deleteChange(Change change) {
    user.changes?.remove(change);
    setDates();

    _updateAccountAfterChangeDelete(change);

    _sortAccounts();
    _sortCategories();

    notifyListeners();

    saveData();
  }

  //* HESAP METODLARI

  void addAccount(Account account) {
    _updateUserAfterAccountAdd(account);

    user.accounts?.add(account);

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
    _updateUserAfterAccountDelete(user.accounts![index]);
    user.accounts?.removeAt(index);

    notifyListeners();
    saveData();
  }

  //* KATEGORI METODLARI

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

  //* TRANSFER METODLARI

  TransferError transferAccounts(
    Account? transferFrom,
    Account? transferTo,
    double amount,
  ) {
    // transfer yapilan hesaplarin bakiyelerini guncelle
    if (transferFrom != null && transferTo != null) {
      if (transferFrom.balance < amount) {
        return TransferError.accountBalanceIsNotEnough;
      }
      if (transferFrom == transferTo) {
        return TransferError.accountIsSame;
      }

      transferFrom.balance -= amount;
      transferTo.balance += amount;

      notifyListeners();
      saveData();

      return TransferError.success;
    }
    return TransferError.accountNotFound;
  }

  //* GIZLI METODLAR

  void _updateAccountAfterChangeAdd(Change change) {
    // hesabi bul
    Account tempAcc = user.accounts!.firstWhere(
      (element) => change.account == element.name,
    );

    // hesabin bakiyesini guncelle
    tempAcc.balance += change.amount;

    // tarih bu ay ve bu yil mi diye bak
    final now = DateTime.now();
    bool isDateUp = DateTime.parse(change.date).month == now.month &&
        DateTime.parse(change.date).year == now.year;

    if (isDateUp) {
      // hesabin bu ayki gelir-giderlerini guncelle
      if (change.isIncome) {
        tempAcc.monthlyIncome += change.amount;
      } else {
        tempAcc.monthlyExpense += change.amount.abs();
      }
    }

    _updateUserAfterChangeAdd(change, isDateUp);
  }

  void _updateAccountAfterChangeUpdate(Change oldChange, Change newChange) {
    // hesabi bul
    Account tempAcc = user.accounts!.firstWhere(
      (element) => oldChange.account == element.name,
    );

    // hesabin bakiyesini guncelle
    tempAcc.balance -= oldChange.amount;
    tempAcc.balance += newChange.amount;

    // tarih bu ay ve bu yil mi diye bak
    final now = DateTime.now();
    bool isDateUp = DateTime.parse(newChange.date).month == now.month &&
        DateTime.parse(newChange.date).year == now.year;

    // hesabin bu ayki gelir-giderlerini guncelle
    if (newChange.isIncome) {
      tempAcc.monthlyIncome -= oldChange.amount;
      if (isDateUp) tempAcc.monthlyIncome += newChange.amount;
    } else {
      tempAcc.monthlyExpense -= oldChange.amount.abs();
      if (isDateUp) tempAcc.monthlyExpense += newChange.amount.abs();
    }

    _updateUserAfterChangeUpdate(oldChange, newChange, isDateUp);
  }

  void _updateAccountAfterChangeDelete(Change change) {
    // hesabi bul
    Account tempAcc = user.accounts!.firstWhere(
      (element) => change.account == element.name,
    );

    // hesabin bakiyesini guncelle
    tempAcc.balance -= change.amount;

    // tarih bu ay ve bu yil mi diye bak
    final now = DateTime.now();
    bool isDateUp = DateTime.parse(change.date).month == now.month &&
        DateTime.parse(change.date).year == now.year;

    if (isDateUp) {
      // hesabin bu ayki gelir-giderlerini guncelle
      if (change.isIncome) {
        tempAcc.monthlyIncome -= change.amount;
      } else {
        tempAcc.monthlyExpense -= change.amount.abs();
      }
    }

    _updateUserAfterChangeDelete(change, isDateUp);
  }

  void _updateUserAfterChangeAdd(Change change, bool isDateUp) {
    // kullanici bakiyesini guncelle
    user.balance += change.amount;

    // kullanicinin bu ayki gelir-giderlerini guncelle
    if (isDateUp) {
      if (change.isIncome) {
        user.monthlyIncome += change.amount;
      } else {
        user.monthlyExpense += change.amount.abs();
      }
    }
  }

  void _updateUserAfterChangeUpdate(
      Change oldChange, Change newChange, bool isDateUp) {
    // kullanici bakiyesini guncelle
    user.balance -= oldChange.amount;
    user.balance += newChange.amount;

    // kullanicinin bu ayki gelir-giderlerini guncelle
    if (newChange.isIncome) {
      user.monthlyIncome -= oldChange.amount;
      if (isDateUp) user.monthlyIncome += newChange.amount;
    } else {
      user.monthlyExpense -= oldChange.amount.abs();
      if (isDateUp) user.monthlyExpense += newChange.amount.abs();
    }
  }

  void _updateUserAfterChangeDelete(Change change, bool isDateUp) {
    // kullanici bakiyesini guncelle
    user.balance -= change.amount;

    // kullanicinin bu ayki gelir-giderlerini guncelle
    if (isDateUp) {
      if (change.isIncome) {
        user.monthlyIncome -= change.amount;
      } else {
        user.monthlyExpense -= change.amount.abs();
      }
    }
  }

  void _updateUserAfterAccountAdd(Account account) {
    // kullanici bakiyesini guncelle
    user.balance += account.balance;
  }

  void _updateUserAfterAccountDelete(Account account) {
    // kullanici bakiyesini guncelle
    user.balance -= account.balance;
  }

  void _sortCategories() {
    // bu ayki tum gelir-giderleri baska bir listeye cek
    final now = DateTime.now();
    var tempChanges = user.changes?.where((element) {
      return DateTime.parse(element.date).month == now.month &&
          DateTime.parse(element.date).year == now.year;
    }).toList();

    // tum kategorilerde gez
    Map<Category, int> categoriesSortedMap = {};
    for (var category in user.categories ?? [Category()]) {
      int counter = 0;
      // yeni gelir-giderler listesini gez
      for (var change in tempChanges ?? []) {
        // bu kategoriye uygun gelir-gider varsa sayac arttir
        if (category.name == change.category) counter++;
      }
      // kategoriye ait gelir-gider sayisini listeye ekle
      categoriesSortedMap[category] = counter;
    }

    // kategorileri gelir-gider sayisina gore sirala
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

  void _sortAccounts() {
    // hesaplari bakiyelere gore buyukten kucuge sirala
    user.accounts?.sort(
      (a, b) => b.balance.compareTo(a.balance),
    );
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
}
