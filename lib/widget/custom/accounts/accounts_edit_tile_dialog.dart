import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';
import '../index.dart';

class AccountsEditTileDialog extends StatefulWidget {
  const AccountsEditTileDialog({
    super.key,
    required this.onSave,
    required this.user,
    required this.index,
  });

  final User user;
  final int index;
  final void Function(Account newCategory) onSave;

  @override
  State<AccountsEditTileDialog> createState() => _AccountsEditTileDialogState();
}

class _AccountsEditTileDialogState extends State<AccountsEditTileDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int active = 0;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.user.accounts[widget.index].name;
    active = findColorIndex(widget.user.accounts[widget.index]);
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
              label: BaseString.account,
              isAccountEdit: true,
              accounts: widget.user.accounts,
              editAccount: widget.user.accounts[widget.index],
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            CustomAccountHorizontalListView(
              active: active,
              onTap: _changeAccountActive,
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

  void _changeAccountActive(int index) {
    active = index;
    setState(() {});
  }

  void _bottomSheetOnComplete() {
    if (_formKey.currentState!.validate()) {
      Account tempAcc = widget.user.accounts[widget.index];
      widget.onSave(
        Account(
          name: _controller.text.trim(),
          balance: tempAcc.balance,
          monthlyIncome: tempAcc.monthlyIncome,
          monthlyExpense: tempAcc.monthlyExpense,
          color: colorToString(BaseColor.colors[active]),
        ),
      );
      clearInputs([_controller]);
      Navigator.of(context).pop();
    }
  }
}