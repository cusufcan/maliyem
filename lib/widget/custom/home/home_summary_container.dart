import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/int_helper.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:provider/provider.dart';

class HomeSummaryContainer extends StatelessWidget {
  const HomeSummaryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Consumer<UserModel>(
        builder: (context, value, child) {
          return BaseText(
            '${formatNumber(num: value.user.balance, short: true)} ${BaseString.tl}',
            alignment: Alignment.centerLeft,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          );
        },
      ),
    );
  }
}
