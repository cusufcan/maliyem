import 'package:flutter/material.dart';

import '../../constant/index.dart';

class BaseBottomBar extends StatelessWidget {
  const BaseBottomBar({
    super.key,
    this.onTap,
    required this.active,
  });

  final void Function(int i)? onTap;
  final int active;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: active,
      items: const [
        BottomNavigationBarItem(
          icon: BaseIcon.homeOutlined,
          activeIcon: BaseIcon.home,
          label: BaseString.home,
          tooltip: BaseString.home,
        ),
        BottomNavigationBarItem(
          icon: BaseIcon.walletOutlined,
          activeIcon: BaseIcon.wallet,
          label: BaseString.accounts,
          tooltip: BaseString.accounts,
        ),
      ],
    );
  }
}
