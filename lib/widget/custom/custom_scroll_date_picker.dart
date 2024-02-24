import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class CustomScrollDatePicker extends StatelessWidget {
  const CustomScrollDatePicker({
    super.key,
    this.date,
    required this.onChanged,
    this.color = BaseColor.surface,
  });

  final DateTime? date;
  final void Function(DateTime value) onChanged;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: BaseSize.xxLg,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(BaseSize.semiMed),
        child: ScrollDatePicker(
          locale: const Locale(BaseString.tr),
          options: DatePickerOptions(
            isLoop: false,
            backgroundColor: color,
          ),
          selectedDate: date ?? DateTime.now(),
          onDateTimeChanged: onChanged,
        ),
      ),
    );
  }
}
