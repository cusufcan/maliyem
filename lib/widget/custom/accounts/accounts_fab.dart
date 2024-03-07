import 'package:flutter/material.dart';

import '../../../constant/index.dart';
import '../../base/index.dart';

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
