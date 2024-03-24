import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/widget/base/base_container.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../constant/index.dart';

class CustomScrollDatePicker extends StatelessWidget {
  const CustomScrollDatePicker({
    super.key,
    this.date,
    required this.onChanged,
    this.color,
  });

  final DateTime? date;
  final void Function(DateTime value) onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var tempColor = Theme.of(context).dialogBackgroundColor;
    return BaseContainer(
      color: color ?? tempColor,
      height: BaseSize.xxLg,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(BaseSize.semiMed),
        child: ScrollDatePicker(
          locale: const Locale(BaseString.tr),
          options: DatePickerOptions(
            isLoop: false,
            backgroundColor: color ?? tempColor,
          ),
          selectedDate: date ?? DateTime.now(),
          onDateTimeChanged: onChanged,
        ),
      ),
    );
  }
}
