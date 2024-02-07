import 'dart:ui';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/bloc/home/home_bloc.dart';
import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/bloc/watch_history/watch_history_bloc.dart';
import 'package:anime_red/presentation/bloc/watch_list/watch_list_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:anime_red/utils/preference/preference_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    final screenWidth = context.screenWidth;

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
                        child: ThemeButtonWidget(
                            minWidth: screenWidth * 0.5,
                            child: const Text(
                              "Explore Now",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: AppFontWeight.bolder,
                                fontSize: AppFontSize.large,
                              ),
                            ),
                            onTap: () async {
                              await PreferenceUtil.setInitialLaunch()
                                  .then((value) {
                                context
                                    .read<HomeBloc>()
                                    .add(const HomeLoadData());
                                context
                                    .read<RecentAnimeBloc>()
                                    .add(const RecentAnimeLoadData());

                                context
                                    .read<WatchListBloc>()
                                    .add(const WatchListGetAll());

                                context
                                    .read<WatchHistoryBloc>()
                                    .add(const WatchHistoryGetAll());

                                AppNavigator.push(
                                  context: context,
                                  screenName: AppRouter.HOME_SCREEN,
                                );
                              });
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
