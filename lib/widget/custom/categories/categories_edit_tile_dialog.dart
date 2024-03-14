import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:provider/provider.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';

class CategoriesEditTileDialog extends StatefulWidget {
  const CategoriesEditTileDialog({
    super.key,
    required this.onSave,
    required this.index,
  });

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
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        _controller.text = value.user.categories![widget.index].name;
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
                  editCategory: value.user.categories![widget.index],
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
      },
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
