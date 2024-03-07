import 'package:flutter/material.dart';

import '../../constant/index.dart';
import 'index.dart';

class BaseAlertDialog extends StatelessWidget {
  const BaseAlertDialog({
    super.key,
    required this.title,
    this.desc,
    this.ok = BaseString.ok,
    required this.onPressed,
  });

  final String title;
  final String? desc;
  final String ok;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BaseSize.med),
      ),
      scrollable: true,
      title: BaseText(
        title,
        alignment: Alignment.centerLeft,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      content: desc != null ? BaseText(desc!) : null,
      actions: [
        ButtonBar(
          children: [
            TextButton(
              onPressed: onPressed,
              child: BaseText(ok),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const BaseText(BaseString.cancel),
            ),
          ],
        )
      ],
    );
  }
}
