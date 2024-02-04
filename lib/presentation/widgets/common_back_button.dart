import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:flutter/material.dart';

class CommonBackButtonWidget extends StatelessWidget {
  const CommonBackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.keyboard_arrow_left_outlined,
          color: AppColors.white,
          size: 25,
        ),
      ),
    );
  }
}
