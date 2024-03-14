import '../model/index.dart';

Account findAccount(User user, String name) {
  return user.accounts?.firstWhere(
        (element) => element.name == name,
      ) ??
      Account();
}

bool isAccountsHaveChange(User user, Account account) {
  for (var change in user.changes ?? []) {
    if (change.account == account.name) return true;
  }
  return false;
}

bool isCategoryHaveChange(User user, Category category) {
  for (var change in user.changes ?? []) {
    if (change.category == category.name) return true;
  }
  return false;
}
