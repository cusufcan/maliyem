part of 'categories_view.dart';

abstract class _CategoriesViewModel extends State<CategoriesView> {
  final TextEditingController accountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _openAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return CustomCategoryBottomSheet(
              isCategoryAdd: true,
              onSave: (name) {
                value.addCategory(Category(name: name));
              },
            );
          },
        );
      },
    );
  }

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
                value.deleteCategory(index);
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
              return CategoriesEditTileDialog(
                index: index,
                onSave: (newCategory) {
                  value.updateCategory(
                    value.user.categories![index],
                    newCategory,
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
