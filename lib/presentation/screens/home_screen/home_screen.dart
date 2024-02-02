import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';

import 'widgets/recent_release.dart';
import 'widgets/search_and_bookmark.dart';
import 'widgets/top_airing.dart';
import 'widgets/watch_history.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: AppPadding.normalScreenPadding,
                child: Column(
                  children: [
                    HomeAppbarWidget(),
                    Gap(H: 10),
                    CustomSmallTitleWIdget(title: "Top Airing"),
                    // Gap(H: 10),
                  ],
                ),
              ),

              // DON"T NEED ANY PADDING HERE
              TopAiringSliderWidget(),

              Padding(
                padding: AppPadding.normalScreenPadding,
                child: HomeSearchAndBookMarkWidget(),
              ),

              Padding(
                padding: AppPadding.normalScreenPadding,
                child: HomeWatchHistoryWidget(),
              ),

              Padding(
                padding: AppPadding.normalScreenPadding,
                child: HomeRecentReleaseWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: "landing_explore",
          child: Image.asset(
            AppImageAssets.logo,
            height: 50,
          ),
        ),
        IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.white,
              size: 25,
            ))
      ],
    );
  }
}
