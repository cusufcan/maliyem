import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/user.dart';

Account findAccount(User user, String name) {
  return user.accounts.firstWhere(
    (element) => element.name == name,
  );
}

bool isAccountsHaveChange(User user, Account account) {
  for (var change in user.changes) {
    if (change.account == account.name) return true;
  }
  return false;
}
