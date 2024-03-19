import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/model/index.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:gelir_gider_takibi/widget/custom/transfer/transfer_dropdown_button.dart';

class TransferDropdownContent extends StatelessWidget {
  const TransferDropdownContent({
    super.key,
    required this.onChanged,
    required this.accountForTransfer,
    required this.title,
  });

  final void Function(Account? acc) onChanged;
  final Account? accountForTransfer;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: BaseSize.xSm),
          child: BaseText(
            title,
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const BaseHeightBox(),
        TransferDropdownButton(
          accountForTransfer: accountForTransfer,
          hint: title,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
