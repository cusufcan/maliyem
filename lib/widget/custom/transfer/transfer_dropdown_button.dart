import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/helper/index.dart';
import 'package:gelir_gider_takibi/model/index.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:provider/provider.dart';

class TransferDropdownButton extends StatelessWidget {
  const TransferDropdownButton({
    super.key,
    required this.onChanged,
    required this.accountForTransfer,
    required this.hint,
  });

  final void Function(Account? acc) onChanged;
  final Account? accountForTransfer;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return BaseContainer(
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<Account>(
                  isExpanded: true,
                  isDense: true,
                  borderRadius: BorderRadius.circular(
                    BaseSize.sm,
                  ),
                  underline: const SizedBox(),
                  padding: const EdgeInsets.all(
                    BaseSize.sm,
                  ),
                  hint: Text(hint),
                  value: accountForTransfer,
                  items: userModel.user.accounts
                      ?.map(
                        (account) => DropdownMenuItem<Account>(
                          value: account,
                          child: Text(account.name),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
              Expanded(
                child: BaseText(
                  "${BaseString.tl} ${formatNumber(num: accountForTransfer?.balance ?? BaseSize.none)} ",
                  alignment: Alignment.centerRight,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
