part of 'categories_view.dart';

abstract class CategoriesViewModel extends State<CategoriesView> {
  final TextEditingController accountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _saveData() {
    widget.sharedManager.setString(
      SharedEnum.save,
      jsonEncode(widget.user.toJson()),
    );
  }

  void _deleteCategory(int index) {
    widget.user.categories.removeAt(index);
    Navigator.of(context).pop();
    setState(() {});
  }

  void _openAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomCategoryBottomSheet(
          isCategoryAdd: true,
          user: widget.user,
          onSave: (value) {
            _addCategory(
              Category(name: value),
            );
          },
        );
      },
    );
  }

  _addCategory(Category category) {
    widget.user.categories.add(category);
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
          onPressed: () => _deleteCategory(index),
        );
      },
    );
  }

  void _updateCategory(Category oldCategory, Category newCategory) {
    int index = widget.user.categories.indexOf(oldCategory);
    widget.user.categories.remove(oldCategory);
    widget.user.categories.insert(index, newCategory);
    _updateAllChanges(oldCategory, newCategory);
    setState(() {});
  }

  void _updateAllChanges(Category oldCategory, Category newCategory) {
    for (var change in widget.user.changes) {
      if (change.category == oldCategory.name) {
        change.category = newCategory.name;
      }
    }
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
          content: CategoriesEditTileDialog(
            user: widget.user,
            index: index,
            onSave: (newCategory) {
              _updateCategory(
                widget.user.categories[index],
                newCategory,
              );
            },
          ),
        );
      },
    );
  }
}
