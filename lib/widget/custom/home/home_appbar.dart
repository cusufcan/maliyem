import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BaseText(
        BaseString.hello,
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      // actions: [
      //   ElevatedButton.icon(
      //     onPressed: () {},
      //     icon: const Icon(Icons.date_range_outlined),
      //     label: const Row(
      //       children: [
      //         Text('February'),
      //       ],
      //     ),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {},
      //     style: ElevatedButton.styleFrom(
      //       shape: const CircleBorder(),
      //     ),
      //     child: const Icon(Icons.arrow_drop_down_outlined),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
