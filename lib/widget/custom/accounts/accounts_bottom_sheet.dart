import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';
import '../index.dart';

class AccountsBottomSheet extends StatefulWidget {
  const AccountsBottomSheet({
    super.key,
    required this.onSave,
    required this.accounts,
  });

  final List<Account> accounts;
  final void Function(String text, String color) onSave;

  @override
  State<AccountsBottomSheet> createState() => _AccountsBottomSheetState();
}

class _AccountsBottomSheetState extends State<AccountsBottomSheet> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int active = 0;

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
              isAccountAdd: true,
              accounts: widget.accounts,
              autoFocus: true,
              maxLength: BaseSize.stringMax,
              controller: _controller,
              label: BaseString.account,
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
      widget.onSave(
        _controller.text.trim(),
        colorToString(BaseColor.colors[active]),
      );
      clearInputs([_controller]);
      Navigator.of(context).pop();
    }
  }

  void _changeAccountActive(int index) {
    active = index;
    setState(() {});
  }
}
