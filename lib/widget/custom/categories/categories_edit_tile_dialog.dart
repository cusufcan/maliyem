import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';

class CategoriesEditTileDialog extends StatefulWidget {
  const CategoriesEditTileDialog({
    super.key,
    required this.onSave,
    required this.user,
    required this.index,
  });

  final User user;
  final int index;
  final void Function(Category newCategory) onSave;

  @override
  State<CategoriesEditTileDialog> createState() =>
      _CategoriesEditTileDialogState();
}

class _CategoriesEditTileDialogState extends State<CategoriesEditTileDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.user.categories[widget.index].name;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseInput(
              autoFocus: true,
              maxLength: BaseSize.stringMax,
              controller: _controller,
              label: BaseString.category,
              isCategoryEdit: true,
              categories: widget.user.categories,
              editCategory: widget.user.categories[widget.index],
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            BaseElevatedButton(
              onPressed: _bottomSheetOnComplete,
              text: BaseString.edit,
            ),
            const BaseHeightBox(),
          ],
        ),
      ),
    );
  }

  void _bottomSheetOnComplete() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        Category(
          name: _controller.text.trim(),
        ),
      );
      clearInputs([_controller]);
      Navigator.of(context).pop();
    }
  }
}
