import 'package:anime_red/config/config.dart';
import 'package:flutter/material.dart';

class CustomSmallTitleWidget extends StatelessWidget {
  const CustomSmallTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.red,
          fontWeight: AppFontWeight.normal,
          fontSize: AppFontSize.medium,
        ),
      ),
    );
  }
}
