part of 'home_view.dart';

abstract class _HomeViewModel extends State<HomeView> {
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
          content: Consumer<UserModel>(
            builder: (context, value, child) {
              return HomeEditTileDialog(
                change: change,
                onSave: (Change newChange) {
                  value.updateChange(change, newChange);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openDeleteDialog(Change change) async {
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
                value.deleteChange(change);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
