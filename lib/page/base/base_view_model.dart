part of 'base_view.dart';

abstract class _BaseViewModel extends State<BaseView> {
  List pages = [];
  List fabs = [];

  TextEditingController amount = TextEditingController();

  int active = 0;

  void _changePage(int i) {
    active = i;
    setState(() {});
  }

  void _showHomeSheet(bool isIncome) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return HomeBottomSheet(
          sharedManager: widget.sharedManager,
          user: widget.user,
          amount: amount,
          isIncome: isIncome,
          onSave: (date, categoryIdx, accountIdx) => _addChange(
            isIncome,
            date,
            categoryIdx,
            accountIdx,
          ),
        );
      },
    );
  }

  void _showAccountsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AccountsBottomSheet(
          accounts: widget.user.accounts,
          onSave: (value, colorString) => _addAccount(
            Account(
              name: value,
              balance: BaseSize.none,
              monthlyIncome: BaseSize.none,
              monthlyExpense: BaseSize.none,
              color: colorString,
            ),
          ),
        );
      },
    );
  }

  void _addChange(
    bool isIncome,
    DateTime date,
    int categoryIndex,
    int accountIndex,
  ) {
    final change = Change(
      account: widget.user.accounts[accountIndex].name,
      category: widget.user.categories[categoryIndex].name,
      amount: double.parse(amount.text),
      date: date.toString(),
      isIncome: isIncome,
    );
    widget.user.changes.add(change);
    widget.user.balance += widget.user.changes.last.amount;
    if (DateTime.parse(change.date).month == DateTime.now().month) {
      if (isIncome) {
        widget.user.monthlyIncome += (change.amount);
      } else {
        widget.user.monthlyExpense += -(change.amount);
      }
    }
    setState(() {});
  }

  void _addAccount(Account account) {
    widget.user.accounts.add(account);
    setState(() {});
  }
}
