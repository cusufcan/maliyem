import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/color_helper.dart';
import 'package:gelir_gider_takibi/model/name.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/base/base_width_box.dart';

class CustomHorizontalListView extends StatelessWidget {
  const CustomHorizontalListView({
    super.key,
    required this.visible,
    required this.count,
    required this.active,
    required this.onTap,
    required this.list,
    required this.title,
    this.isColor = false,
    this.onBtnTap,
    required this.user,
  });

  final User user;
  final String title;
  final bool visible;
  final int count;
  final int active;
  final void Function(int index) onTap;
  final void Function()? onBtnTap;
  final List<Name> list;
  final bool isColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                title,
                alignment: Alignment.centerLeft,
              ),
              BaseText(
                BaseString.add,
                alignment: Alignment.centerLeft,
                onTap: onBtnTap,
                style: const TextStyle(
                  color: BaseColor.activeGreen,
                ),
              ),
            ],
          ),
          const BaseHeightBox(height: BaseSize.semiMed),
          SizedBox(
            height: BaseSize.xLg,
            child: ListView.builder(
              itemCount: count,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    BaseContainer(
                      onTap: () => onTap(index),
                      color: isColor
                          ? BaseColor.colors[findColorIndex(
                              user.accounts[index],
                            )]
                          : BaseColor.white,
                      border: Border.all(
                        strokeAlign: BaseSize.xxSm,
                        width: BaseSize.xxSm,
                        color: active == index
                            ? BaseColor.activeGreen
                            : BaseColor.transparent,
                      ),
                      child: BaseText(
                        list[index].name,
                        style: TextStyle(
                          color: isColor
                              ? getTextColor(BaseColor.colors[index])
                              : getTextColor(BaseColor.white),
                        ),
                      ),
                    ),
                    const BaseWidthBox(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// active == index