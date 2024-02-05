import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import 'widgets/recent_release.dart';
import 'widgets/search_and_watchlist.dart';
import 'widgets/top_airing.dart';
import 'widgets/watch_history.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(const HomeLoadData());
      context.read<RecentAnimeBloc>().add(const RecentAnimeLoadData());
    });

    final PageStorageBucket homeBucket = PageStorageBucket();
    return PageStorage(
      bucket: homeBucket,
      key: UniqueKey(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: AppPadding.normalScreenPadding,
                  child: Column(
                    children: [
                      HomeAppbarWidget(),
                      // Gap(H: 10),
                      // CustomSmallTitleWIdget(title: "Top Airing"),
                      // Gap(H: 10),
                    ],
                  ),
                ),

                // DON"T NEED ANY PADDING HERE
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeFailure) {
                      return Center(
                        child: AppErrorWidget(
                          onTap: () {
                            // TODO IMPLEMENT ALL STARTUP FUNCTIONS RETRY
                          },
                          errorMessage: state.message,
                        ),
                      );
                    }
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopAiringSliderWidget(),
                        Padding(
                          padding: AppPadding.normalScreenPadding,
                          child: HomeSearchAndWatchlistWidget(),
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
                    );
                  },
                ),
              ],
            ),
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
            onPressed: () {
              AppNavigator.push(
                  context: context, screenName: AppRouter.GENRE_SCREEN);
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.white,
              size: 25,
            ))
      ],
    );
  }
}
