import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/input_helper.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_elevated_button.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_input.dart';

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
