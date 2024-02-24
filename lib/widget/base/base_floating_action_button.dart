import 'package:flutter/material.dart';

class BaseFloatingActionButton extends StatelessWidget {
  const BaseFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.tooltip,
    required this.icon,
  });

  final void Function() onPressed;
  final String tooltip;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      shape: const CircleBorder(),
      child: icon,
    );
  }
}
