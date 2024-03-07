import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    this.child,
    this.color,
    this.onTap,
    this.onLongPress,
    this.circle = false,
    this.gradient,
    this.shadow = true,
    this.radius = BaseSize.sm,
    this.padding = const EdgeInsets.all(BaseSize.semiMed),
    this.height,
    this.width,
    this.border,
  });

  final Widget? child;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool circle;
  final Gradient? gradient;
  final bool shadow;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color ?? Theme.of(context).cardColor,
          borderRadius: !circle ? BorderRadius.circular(radius) : null,
          border: border,
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
