import 'package:flutter/material.dart';

import '../../../constant/index.dart';

class AccountsFab extends StatelessWidget {
  const AccountsFab({
    super.key,
    required this.addAccount,
  });

  final void Function() addAccount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: BaseSize.fabBottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: addAccount,
                  shape: const CircleBorder(),
                  tooltip: BaseString.add,
                  child: BaseIcon.add,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
