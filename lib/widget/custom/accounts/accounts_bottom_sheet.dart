import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../base/index.dart';
import '../index.dart';

class AccountsBottomSheet extends StatefulWidget {
  const AccountsBottomSheet({
    super.key,
    required this.onAccountSave,
  });

  final void Function(
    String name,
    String amount,
    String color,
  ) onAccountSave;

  @override
  State<AccountsBottomSheet> createState() => _AccountsBottomSheetState();
}

class _AccountsBottomSheetState extends State<AccountsBottomSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + BaseSize.md,
            top: BaseSize.semiLg,
          ) +
          const EdgeInsets.symmetric(
            horizontal: BaseSize.md,
          ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              '${BaseString.account} ${BaseString.add}',
              alignment: Alignment.centerLeft,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const BaseHeightBox(height: BaseSize.lg),
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
              prefix: const Text(BaseString.tl),
              maxLength: BaseSize.intMax,
              type: TextInputType.number,
              action: TextInputAction.done,
              label: BaseString.amount,
              controller: _amountController,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            Consumer<AccountsSheetModel>(
              builder: (context, accountsSheetModel, child) {
                return CustomAccountHorizontalListView(
                  active: accountsSheetModel.active,
                  onTap: (i) => accountsSheetModel.changeAccountActive(i),
                );
              },
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            Consumer<AccountsSheetModel>(
              builder: (context, accountsSheetModel, child) {
                return BaseElevatedButton(
                  onPressed: () {
                    final response = _bottomSheetOnComplete(
                      accountsSheetModel.active,
                    );
                    if (response) accountsSheetModel.clearValues();
                  },
                  text: BaseString.add,
                );
              },
            ),
            const BaseHeightBox(),
          ],
        ),
      ),
    );
  }

  bool _bottomSheetOnComplete(int active) {
    if (_formKey.currentState!.validate()) {
      widget.onAccountSave(
        _nameController.text.trim(),
        _amountController.text.trim(),
        colorToString(BaseColor.colors[active]),
      );
      clearInputs([_nameController, _amountController]);
      Navigator.of(context).pop();
      return true;
    }
    return false;
  }
}
