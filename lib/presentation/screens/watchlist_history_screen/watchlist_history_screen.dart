// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar_text.dart';

enum HistoryScreenType { history, watchlist }

final watchlistCollections = [
  "All",
  "Currently Watching",
  "On-hold",
  "Dropped",
  "Completed",
  "Plan to Watch",
];

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
                const WatchlistViewWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WatchlistViewWidget extends StatefulWidget {
  const WatchlistViewWidget({
    super.key,
  });

  @override
  State<WatchlistViewWidget> createState() => _WatchlistViewWidgetState();
}

class _WatchlistViewWidgetState extends State<WatchlistViewWidget> {
  late ValueNotifier<String> selectedCollection;

  @override
  void initState() {
    selectedCollection = ValueNotifier(watchlistCollections.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              watchlistCollections.length,
              (index) => WatchlistCollectionSelectorTileWidget(
                holdingValue: watchlistCollections[index],
                selected: selectedCollection,
              ),
            ),
          ),
          const Gap(H: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => const HistorySearchTileWidget(),
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}

class WatchlistCollectionSelectorTileWidget extends StatelessWidget {
  const WatchlistCollectionSelectorTileWidget({
    super.key,
    required this.holdingValue,
    required this.selected,
  });

  final ValueNotifier<String> selected;
  final String holdingValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selected.value = holdingValue;
        selected.notifyListeners();
      },
      child: ValueListenableBuilder(
          valueListenable: selected,
          builder: (context, value, _) {
            return Container(
              decoration: BoxDecoration(
                color: value == holdingValue ? AppColors.white : AppColors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 10,
              ),
              child: Text(
                holdingValue,
                style: TextStyle(
                  color:
                      value == holdingValue ? AppColors.black : AppColors.white,
                  fontWeight: value == holdingValue
                      ? AppFontWeight.bold
                      : AppFontWeight.normal,
                  fontSize: AppFontSize.small,
                ),
              ),
            );
          }),
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

class HistorySearchTileWidget extends StatelessWidget {
  const HistorySearchTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: AppPadding.normalScreenPadding,
            height: 100,
            // width: tileWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImageAssets.landgingBg,
                ),
              ),
            ),

            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.white,
                ),
                child: const Text(
                  "SUB",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: AppFontWeight.bold,
                    fontSize: AppFontSize.small,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(H: 5),
        const Text(
          "Naruto Shippuden",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: AppFontWeight.bold,
            fontSize: AppFontSize.small,
          ),
        )
      ],
    );
  }
}
