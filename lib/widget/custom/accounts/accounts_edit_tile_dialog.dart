import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

import '../../../constant/index.dart';
import '../../../helper/index.dart';
import '../../../model/index.dart';
import '../../base/index.dart';
import '../index.dart';

class AccountsEditTileDialog extends StatefulWidget {
  const AccountsEditTileDialog({
    super.key,
    required this.onSave,
    required this.index,
  });

  final int index;
  final void Function(Account newAcc) onSave;

  @override
  State<AccountsEditTileDialog> createState() => _AccountsEditTileDialogState();
}

class _AccountsEditTileDialogState extends State<AccountsEditTileDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        _controller.text = value.user.accounts![widget.index].name;

        Future.delayed(Duration.zero).whenComplete(
          () => Provider.of<AccountsDialogModel>(
            context,
            listen: false,
          ).changeAccountActive(
            findColorIndex(
              value.user.accounts![widget.index],
            ),
          ),
        );

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
                  editAccount: value.user.accounts![widget.index],
                ),
                const BaseHeightBox(height: BaseSize.semiMed),
                Consumer<AccountsDialogModel>(
                  builder: (context, accountsDialogModel, child) {
                    return CustomAccountHorizontalListView(
                      active: accountsDialogModel.active,
                      onTap: (i) => accountsDialogModel.changeAccountActive(i),
                    );
                  },
                ),
                const BaseHeightBox(height: BaseSize.semiMed),
                Consumer<AccountsDialogModel>(
                  builder: (context, accountsDialogModel, child) {
                    return BaseElevatedButton(
                      onPressed: () {
                        _bottomSheetOnComplete(
                          value.user,
                          accountsDialogModel.active,
                        );
                        accountsDialogModel.clearValues();
                      },
                      text: BaseString.edit,
                    );
                  },
                ),
                const BaseHeightBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bottomSheetOnComplete(User user, int active) {
    if (_formKey.currentState!.validate()) {
      Account tempAcc = user.accounts![widget.index];
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
