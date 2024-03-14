part of 'base_view.dart';

abstract class _BaseViewModel extends State<BaseView> {
  List pages = [];
  List fabs = [];

  final TextEditingController _controller = TextEditingController();

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
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return HomeBottomSheet(
              amount: _controller,
              isIncome: isIncome,
              onSave: (date, categoryIdx, accountIdx) {
                value.addChange(Change(
                  account: value.user.accounts![accountIdx].name,
                  category: value.user.categories![categoryIdx].name,
                  amount: double.parse(_controller.text),
                  date: date.toString(),
                  isIncome: isIncome,
                ));
              },
            );
          },
        );
      },
    );
  }

  void _showAccountsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, user, child) {
            return AccountsBottomSheet(
              onAccountSave: (name, amount, colorString) {
                user.addAccount(
                  Account(
                    name: name,
                    balance: double.parse(amount),
                    monthlyIncome: BaseSize.none,
                    monthlyExpense: BaseSize.none,
                    color: colorString,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
