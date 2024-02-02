import 'dart:ui';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppImageAssets.landgingBg,
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                blendMode: BlendMode.overlay,
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.black.withOpacity(0.5),
              child: const LandingWidgetsView(),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingWidgetsView extends StatelessWidget {
  const LandingWidgetsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;

    return Padding(
      padding: AppPadding.normalScreenPadding,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
        tween: Tween(begin: 20, end: 0),
        builder: (context, currentValue, child) {
          return Opacity(
            opacity: 1 - currentValue * 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImageAssets.logo,
                      height: screenHeight * 0.06,
                    ),
                    Gap(H: 30 + currentValue),
                    const Text(
                      "Explore the world of Anime, You can stream thousands of Anime at AnimeRED for free",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFontWeight.normal,
                        fontSize: AppFontSize.medium,
                      ),
                    ),
                    Gap(H: 10 + currentValue),
                    const Text(
                      "Enjoy Ad free quality content",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFontWeight.normal,
                        fontSize: AppFontSize.medium,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Hero(
                        tag: "landing_explore",
                        child: ThemeButtonWidget(onTap: () {
                          AppNavigator.push(
                            context: context,
                            screenName: AppRouter.HOME_SCREEN,
                          );
                        }),
                      ),
                      Gap(H: screenHeight * 0.06 - currentValue),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
