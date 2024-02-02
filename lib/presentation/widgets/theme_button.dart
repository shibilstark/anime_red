import 'package:anime_red/config/config.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ThemeButtonWidget extends StatelessWidget {
  const ThemeButtonWidget({
    super.key,
    required this.onTap,
    this.minWidth,
    this.backgroundColor = AppColors.red,
    this.borderRadius = 5,
  });

  final double? minWidth;
  final Color backgroundColor;
  final double borderRadius;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return MaterialButton(
      elevation: 0,
      color: backgroundColor,
      minWidth: minWidth ?? screenWidth * 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onTap,
      child: const Text(
        "Explore Now",
        style: TextStyle(
          color: AppColors.white,
          fontWeight: AppFontWeight.bolder,
          fontSize: AppFontSize.large,
        ),
      ),
    );
  }
}
