import 'package:flutter/material.dart';

import '../../config/config.dart';

class AppBarTitleTextWidget extends StatelessWidget {
  const AppBarTitleTextWidget({super.key, this.title = "Appbar"});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: AppFontWeight.bold,
        fontSize: AppFontSize.large,
      ),
    );
  }
}
