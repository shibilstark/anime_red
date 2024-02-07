import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/watch_history/watch_history_model.dart/watch_history_model.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/anime/anime_bloc.dart';
import '../../../bloc/watch_history/watch_history_bloc.dart';
import '../../../widgets/network_image_widget.dart';

class HomeWatchHistoryWidget extends StatelessWidget {
  const HomeWatchHistoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;

    return BlocBuilder<WatchHistoryBloc, WatchHistoryState>(
      builder: (context, state) {
        if (state.watchHistory.isEmpty) {
          return const Gap();
        }

        final watchHistoryToShow = state.watchHistory.take(5).toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomSmallTitleWidget(
              title: "Watch History",
            ),
            const Gap(H: 10),
            SizedBox(
              height: screenHeight * 0.16,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HomeWatchHistoryTileWidget(
                    model: watchHistoryToShow[index],
                  );
                },
                separatorBuilder: (context, index) => const Gap(W: 10),
                itemCount: watchHistoryToShow.length,
              ),
            ),
            const Gap(H: 10),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                splashColor: AppColors.grey.withOpacity(0.2),
                onTap: () {
                  AppNavigator.push(
                      context: context,
                      screenName: AppRouter.WATCH_HISTORY_SCREEN);
                },
                child: Hero(
                  tag: "history_hero",
                  flightShuttleBuilder: (flightContext, animation,
                      flightDirection, fromHeroContext, toHeroContext) {
                    return Material(
                      color: Colors.transparent,
                      child: flightDirection == HeroFlightDirection.push
                          ? toHeroContext.widget
                          : const SizedBox(),
                    );
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See full hostory",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: AppFontWeight.normal,
                            fontSize: AppFontSize.large,
                          ),
                        ),
                        Gap(W: 3),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomeWatchHistoryTileWidget extends StatelessWidget {
  const HomeWatchHistoryTileWidget({
    super.key,
    required this.model,
  });

  final WatchHistoryModel model;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final tileWidth = screenWidth * 0.8;
    return GestureDetector(
      onTap: () {
        context.read<AnimeBloc>().add(AnimeGetInfo(model.id));

        AppNavigator.push(
            context: context,
            screenName: AppRouter.ANIME_PLAYER_SCREEN,
            arguments: {"args": (model.id, model.title)});
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: tileWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey, width: 1),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.black,
                    ),
                    child: NetWorkImageWidget(image: model.image),
                  ),
                  LinearProgressIndicator(
                    color: AppColors.red,
                    backgroundColor: AppColors.grey,
                    value: model.totalLength != null &&
                            model.currentPosition != null
                        ? model.currentPosition!.inSeconds /
                            model.totalLength!.inSeconds
                        : 0,
                  )
                ],
              ),
            ),
            const Gap(W: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppFontSize.large,
                    ),
                  ),
                  const Gap(H: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
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
                        fontWeight: AppFontWeight.bolder,
                        fontSize: AppFontSize.verySmall,
                      ),
                    ),
                  ),
                  const Gap(H: 20),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        "EP ${model.currentEpisodeCount}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.red,
                          fontWeight: AppFontWeight.normal,
                          fontSize: AppFontSize.medium,
                        ),
                      ),
                      const Gap(W: 10),
                      const Icon(
                        CupertinoIcons.play_fill,
                        color: AppColors.indicator,
                        size: 18,
                      ),
                      const Gap(W: 10),
                      const Text(
                        "Continue watching",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.indicator,
                          fontWeight: AppFontWeight.normal,
                          fontSize: AppFontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
