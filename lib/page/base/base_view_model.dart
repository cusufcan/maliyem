part of 'base_view.dart';

abstract class _BaseViewModel extends State<BaseView> {
  List<Widget> pages = [];
  List fabs = [];

  final TextEditingController _controller = TextEditingController();

  void _showHomeSheet(bool isIncome) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return HomeBottomSheet(
              amount: _controller,
              isIncome: isIncome,
              onSave: (date, categoryIdx, accountIdx) {
                value.addChange(
                  Change(
                    account: value.user.accounts![accountIdx].name,
                    category: value.user.categories![categoryIdx].name,
                    amount: double.parse(_controller.text),
                    date: date.toString(),
                    isIncome: isIncome,
                  ),
                  context,
                );
              },
            );
          },
        );
      },
    ).whenComplete(() {
      Provider.of<FabModel>(context, listen: false).closeFab();
      Provider.of<HomeSheetModel>(context, listen: false).clearValues();
    });
  }

  void _showAccountsSheet() {
    showModalBottomSheet(
      useSafeArea: true,
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
    ).whenComplete(() {
      Provider.of<AccountsSheetModel>(context, listen: false).clearValues();
    });
  }
}
