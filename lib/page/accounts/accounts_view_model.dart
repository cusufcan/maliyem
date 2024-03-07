part of 'accounts_view.dart';

abstract class _AccountsViewModel extends State<AccountsView> {
  final TextEditingController accountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _saveData() {
    widget.sharedManager.setString(
      SharedEnum.save,
      jsonEncode(widget.user.toJson()),
    );
  }

  void _deleteAccount(int index) {
    widget.accounts.removeAt(index);
    Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> _openDeleteDialog(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseAlertDialog(
          title: BaseString.delete,
          desc: BaseString.deleteDesc,
          ok: BaseString.delete,
          onPressed: () => _deleteAccount(index),
        );
      },
    );
  }

  void _updateAccount(Account oldAccount, Account newAccount) {
    int index = widget.user.accounts.indexOf(oldAccount);
    widget.user.accounts.remove(oldAccount);
    widget.user.accounts.insert(index, newAccount);
    setState(() {});
  }

  Future<void> _openEditDialog(int index) async {
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
          content: AccountsEditTileDialog(
            user: widget.user,
            index: index,
            onSave: (newAccount) {
              _updateAccount(
                widget.user.accounts[index],
                newAccount,
              );
            },
          ),
        );
      },
    );
  }
}
