// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/screens/watchlist_history_screen/widgets/watchlist_view.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar_text.dart';

enum HistoryScreenType { history, watchlist }

class WatchlistHistoryScreen extends StatelessWidget {
  final HistoryScreenType screenType;
  const WatchlistHistoryScreen({
    super.key,
    required this.screenType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.normalScreenPadding,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WatchHistoryAppBarWidget(
                  screenType: screenType,
                ),
                const Gap(H: 20),
                screenType == HistoryScreenType.watchlist
                    ? const WatchlistViewWidget()
                    : const Gap(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WatchHistoryAppBarWidget extends StatelessWidget {
  const WatchHistoryAppBarWidget({
    super.key,
    required this.screenType,
  });

  final HistoryScreenType screenType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CommonBackButtonWidget(),
          const Gap(W: 10),
          Material(
            type: MaterialType.transparency,
            child: Hero(
              tag: screenType == HistoryScreenType.watchlist
                  ? "watchlist_hero"
                  : "history_hero",
              child: AppBarTitleTextWidget(
                title: screenType == HistoryScreenType.watchlist
                    ? "My Watchlist"
                    : "My History",
              ),
            ),
          ),
          const Gap(W: 10),
          const Spacer(),
          const Icon(
            CupertinoIcons.search,
            color: AppColors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}
