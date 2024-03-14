part of 'accounts_view.dart';

abstract class _AccountsViewModel extends State<AccountsView> {
  final TextEditingController accountController = TextEditingController();

  Future<void> _openDeleteDialog(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return BaseAlertDialog(
              title: BaseString.delete,
              desc: BaseString.deleteDesc,
              ok: BaseString.delete,
              onPressed: () {
                value.deleteAccount(index);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
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
          content: Consumer<UserModel>(
            builder: (context, value, child) {
              return AccountsEditTileDialog(
                index: index,
                onSave: (newAccount) {
                  value.updateAccount(
                    value.user.accounts![index],
                    newAccount,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
