import 'package:flutter/material.dart';

class BaseHeightBox extends StatelessWidget {
  const BaseHeightBox({
    super.key,
    this.width = 0,
    this.height = 16,
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
