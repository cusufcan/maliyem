import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import '../../model/index.dart';
import '../base/index.dart';

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
  });

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
    return Material(
      color: BaseColor.transparent,
      child: Visibility(
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
                      Consumer<UserModel>(
                        builder: (context, value, child) {
                          return BaseContainer(
                            onTap: () => onTap(index),
                            color: isColor
                                ? BaseColor.colors[findColorIndex(
                                    value.user.accounts![index],
                                  )]
                                : BaseColor.white,
                            border: Border.all(
                              width: BaseSize.xxSm,
                              color: active == index
                                  ? BaseColor.activeGreen
                                  : BaseColor.transparent,
                            ),
                            child: BaseText(
                              list[index].name,
                              style: TextStyle(
                                fontWeight: active == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isColor
                                    ? getTextColor(
                                        BaseColor.colors[findColorIndex(
                                        value.user.accounts![index],
                                      )])
                                    : getTextColor(BaseColor.white),
                              ),
                            ),
                          );
                        },
                      ),
                      const BaseWidthBox(),
                    ],
                  );
                },
              ),
            ),
            const BaseHeightBox(),
          ],
        ),
      ),
    );
  }
}
