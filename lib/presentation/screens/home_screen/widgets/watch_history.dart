import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWatchHistoryWidget extends StatelessWidget {
  const HomeWatchHistoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final tileWidth = screenWidth * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomSmallTitleWIdget(
          title: "Watch History",
        ),
        const Gap(H: 10),
        SizedBox(
          height: screenHeight * 0.16,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              // height: 100,
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
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AppImageAssets.landgingBg,
                              ),
                            ),
                          ),
                        ),
                        const LinearProgressIndicator(
                          color: AppColors.red,
                          backgroundColor: AppColors.grey,
                          minHeight: 4,
                          value: 0.7,
                        )
                      ],
                    ),
                  ),
                  const Gap(W: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "One Piece",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: AppFontWeight.bolder,
                            fontSize: AppFontSize.smallTitle,
                          ),
                        ),
                        const Gap(W: 10),
                        const Text(
                          "EP 148",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.red,
                            fontWeight: AppFontWeight.normal,
                            fontSize: AppFontSize.medium,
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
                        const Gap(H: 10),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.play_fill,
                              color: AppColors.indicator,
                              size: 18,
                            ),
                            Gap(W: 10),
                            Text(
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
            separatorBuilder: (context, index) => const Gap(W: 10),
            itemCount: 5,
          ),
        ),
        const Gap(H: 10),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            splashColor: AppColors.grey.withOpacity(0.2),
            onTap: () {
              AppNavigator.push(
                  context: context, screenName: AppRouter.WATCH_HISTORY_SCREEN);
            },
            child: Hero(
              tag: "history_hero",
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
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
  }
}
