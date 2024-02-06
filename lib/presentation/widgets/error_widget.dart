import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.onTap,
    this.errorMessage = "No Data Found",
    this.buttonTitle = "Retry",
  });

  final String errorMessage;
  final String buttonTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          AppLottieAssets.screenError,
          backgroundLoading: true,
          fit: BoxFit.fitWidth,
        ),
        Text(
          errorMessage,
          style: const TextStyle(
            color: AppColors.silver,
            fontSize: AppFontSize.small,
            fontWeight: AppFontWeight.normal,
          ),
        ),
        const Gap(H: 30),
        OutlinedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 30))),
          onPressed: onTap,
          child: Text(
            buttonTitle,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.medium),
          ),
        )
      ],
    );
  }
}
