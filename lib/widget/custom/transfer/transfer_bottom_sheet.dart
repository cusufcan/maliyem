import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/helper/error_helper.dart';
import 'package:gelir_gider_takibi/helper/index.dart';
import 'package:gelir_gider_takibi/model/index.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:gelir_gider_takibi/widget/custom/transfer/transfer_dropdown_content.dart';
import 'package:provider/provider.dart';

class TransferBottomSheet extends StatefulWidget {
  const TransferBottomSheet({
    super.key,
    required this.onTransferSave,
  });

  final void Function(
    Account transferFrom,
    Account transferTo,
    double amount,
  ) onTransferSave;

  @override
  State<TransferBottomSheet> createState() => _TransferBottomSheetState();
}

class _TransferBottomSheetState extends State<TransferBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  Account? transferFrom;
  Account? transferTo;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  BaseString.transfer,
                  alignment: Alignment.centerLeft,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const BaseHeightBox(height: BaseSize.lg),
                TransferDropdownContent(
                  accountForTransfer: transferFrom,
                  title: BaseString.sender,
                  onChanged: (acc) {
                    transferFrom = acc;
                    setState(() {});
                  },
                ),
                const BaseHeightBox(height: BaseSize.med),
                TransferDropdownContent(
                  accountForTransfer: transferTo,
                  title: BaseString.receiver,
                  onChanged: (acc) {
                    transferTo = acc;
                    setState(() {});
                  },
                ),
                const BaseWidthBox(width: BaseSize.med),
              ],
            ),
            const BaseHeightBox(height: BaseSize.lg),
            BaseInput(
              prefix: const Text(BaseString.tl),
              maxLength: BaseSize.intMax,
              type: TextInputType.number,
              action: TextInputAction.done,
              label: BaseString.amount,
              controller: _amountController,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            Consumer<UserModel>(
              builder: (context, userModel, child) {
                return BaseElevatedButton(
                  onPressed: () => _bottomSheetOnComplete(userModel),
                  text: BaseString.transfer,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _bottomSheetOnComplete(UserModel userModel) {
    if (_formKey.currentState!.validate()) {
      final result = userModel.transferAccounts(
        transferFrom,
        transferTo,
        double.tryParse(_amountController.text) ?? 0,
      );

      final String message = getTransferErrorMsg(result);

      clearInputs([_amountController]);
      transferFrom = null;
      transferTo = null;
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(BaseString.transfer),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BaseSize.sm),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(BaseString.ok),
              ),
            ],
          );
        },
      );
    }
  }
}
