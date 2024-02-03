import 'package:anime_red/config/config.dart';
import 'package:flutter/material.dart';

class ThemeButtonWidget extends StatelessWidget {
  const ThemeButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.minWidth,
    this.backgroundColor = AppColors.red,
    this.borderRadius = 5,
    this.density,
  });

  final double? minWidth;
  final Color backgroundColor;
  final double borderRadius;
  final void Function() onTap;
  final Widget child;
  final VisualDensity? density;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: backgroundColor,
      visualDensity: density,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
