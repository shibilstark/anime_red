import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';

class CustomCircularIndicatorWidget extends StatelessWidget {
  const CustomCircularIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Gap(H: 10),
        CircleAvatar(
          backgroundColor: AppColors.grey,
          radius: 15,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: CircularProgressIndicator(
              color: AppColors.red,
              backgroundColor: AppColors.grey,
              strokeWidth: 2,
            ),
          ),
        ),
      ],
    );
  }
}
