import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({
    super.key,
    required this.addIncome,
    required this.addExpense,
  });

  final VoidCallback addIncome;
  final VoidCallback addExpense;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: BaseColor.black,
      overlayOpacity: 0.4,
      spacing: BaseSize.xSm,
      spaceBetweenChildren: BaseSize.semiMed,
      children: [
        SpeedDialChild(
          onTap: addExpense,
          shape: const CircleBorder(),
          child: BaseIcon.expenseWhite,
          label: BaseString.expense,
          backgroundColor: BaseColor.expense,
          labelBackgroundColor: BaseColor.expense,
          labelStyle: const TextStyle(color: BaseColor.white),
        ),
        SpeedDialChild(
          onTap: addIncome,
          shape: const CircleBorder(),
          child: BaseIcon.incomeWhite,
          label: BaseString.income,
          backgroundColor: BaseColor.income,
          labelBackgroundColor: BaseColor.income,
          labelStyle: const TextStyle(color: BaseColor.white),
        ),
      ],
    );
  }
}
