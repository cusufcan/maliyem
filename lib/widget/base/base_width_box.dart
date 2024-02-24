import 'package:flutter/material.dart';

class BaseWidthBox extends StatelessWidget {
  const BaseWidthBox({
    super.key,
    this.width = 16,
    this.height = 0,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
