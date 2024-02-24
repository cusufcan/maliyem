import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';

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
    return SizedBox(
      height: BaseSize.xLg,
      child: ListView.builder(
        itemCount: BaseColor.colors.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              BaseContainer(
                width: 50,
                color: BaseColor.colors[index],
                onTap: () => onTap(index),
                border: Border.all(
                  strokeAlign: BaseSize.xxSm,
                  width: BaseSize.xxSm,
                  color: active == index
                      ? BaseColor.activeGreen
                      : BaseColor.transparent,
                ),
              ),
              const BaseWidthBox(),
            ],
          );
        },
      ),
    );
  }
}
