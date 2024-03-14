import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../base/index.dart';
import '../index.dart';

class AccountsBottomSheet extends StatefulWidget {
  const AccountsBottomSheet({
    super.key,
    required this.onAccountSave,
  });

  final void Function(String name, String amount, String color) onAccountSave;

  @override
  State<AccountsBottomSheet> createState() => _AccountsBottomSheetState();
}

class _AccountsBottomSheetState extends State<AccountsBottomSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int active = 0;

  @override
  void initState() {
    super.initState();
    _amountController.text = BaseSize.none.toString();
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseInput(
              autoFocus: true,
              isAccountAdd: true,
              maxLength: BaseSize.stringMax,
              controller: _nameController,
              action: TextInputAction.next,
              label: BaseString.account,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            BaseInput(
              maxLength: BaseSize.intMax,
              type: TextInputType.number,
              action: TextInputAction.done,
              label: BaseString.amount,
              controller: _amountController,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            CustomAccountHorizontalListView(
              active: active,
              onTap: _changeAccountActive,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
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
      widget.onAccountSave(
        _nameController.text.trim(),
        _amountController.text.trim(),
        colorToString(BaseColor.colors[active]),
      );
      clearInputs([_nameController, _amountController]);
      Navigator.of(context).pop();
    }
  }

  void _changeAccountActive(int index) {
    active = index;
    setState(() {});
  }
}
