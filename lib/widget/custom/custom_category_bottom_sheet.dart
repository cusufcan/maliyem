import 'package:flutter/material.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import '../../model/index.dart';
import '../base/index.dart';

class CustomCategoryBottomSheet extends StatefulWidget {
  const CustomCategoryBottomSheet({
    super.key,
    required this.onSave,
    this.user,
    this.isCategoryAdd = false,
    this.isCategoryEdit = false,
    this.index = 0,
  });

  final void Function(String name) onSave;

  final User? user;
  final int index;
  final bool isCategoryAdd;
  final bool isCategoryEdit;

  @override
  State<CustomCategoryBottomSheet> createState() =>
      _CustomCategoryBottomSheetState();
}

class _CustomCategoryBottomSheetState extends State<CustomCategoryBottomSheet> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + BaseSize.med,
            top: BaseSize.semiLg,
          ) +
          const EdgeInsets.symmetric(
            horizontal: BaseSize.med,
          ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              '${BaseString.category} ${BaseString.add}',
              alignment: Alignment.centerLeft,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const BaseHeightBox(height: BaseSize.lg),
            BaseInput(
              autoFocus: true,
              maxLength: BaseSize.stringMax,
              controller: _controller,
              label: BaseString.category,
              isCategoryAdd: widget.isCategoryAdd,
              isCategoryEdit: widget.isCategoryEdit,
              editCategory: widget.user?.categories![widget.index],
            ),
            const BaseHeightBox(height: BaseSize.sm),
            BaseElevatedButton(
              onPressed: _bottomSheetOnComplete,
              text: BaseString.add,
            ),
            const BaseHeightBox(),
          ],
        ),
      ),
    );
  }

  void _bottomSheetOnComplete() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_controller.text.trim());
      clearInputs([_controller]);
      Navigator.of(context).pop();
    }
  }
}
