import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_floating_action_button.dart';

class AccountsFab extends StatelessWidget {
  const AccountsFab({
    super.key,
    required this.addAccount,
  });

  final void Function() addAccount;

  @override
  Widget build(BuildContext context) {
    return BaseFloatingActionButton(
      onPressed: addAccount,
      tooltip: BaseString.add,
      icon: BaseIcon.add,
    );
  }
}
