import 'package:flutter/material.dart';

import '../../constant/index.dart';
import '../base/index.dart';

class CustomAccountHorizontalListView extends StatelessWidget {
  const CustomAccountHorizontalListView({
    super.key,
    required this.active,
    required this.onTap,
  });

  final int active;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BaseColor.transparent,
      child: SizedBox(
        width: BaseSize.xLg,
        height: BaseSize.xLg + 1,
        child: ListView.separated(
          itemCount: BaseColor.colors.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const BaseWidthBox(),
          itemBuilder: (BuildContext context, int index) {
            return BaseContainer(
              width: BaseSize.xLg,
              height: BaseSize.xLg,
              color: BaseColor.colors[index],
              onTap: () => onTap(index),
              border: Border.all(
                width: BaseSize.xxSm,
                color: active == index
                    ? BaseColor.activeGreen
                    : BaseColor.transparent,
              ),
            );
          },
        ),
      ),
    );
  }
}
