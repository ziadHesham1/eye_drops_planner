import 'package:flutter/material.dart';

class AppContainerButton extends StatelessWidget {
  final Function()? onPressed;
  final bool disabled;
  final Widget child;
  final bool roundedCorners;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const AppContainerButton({
    super.key,
    required this.child,
    this.roundedCorners = false,
    this.color,
    this.borderRadius,
    this.margin,
    this.padding,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: color ?? Colors.transparent,
      ),
      margin: margin,
      child: IconButton(
        style: IconButton.styleFrom(
          shape: borderRadius != null
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius!))
              : const ContinuousRectangleBorder(),
          padding: padding ?? EdgeInsets.zero,
          backgroundColor: color,
          highlightColor: Colors.white.withOpacity(0.3),
        ),
        onPressed: onPressed,
        icon: child,
      ),
    );
  }
}
