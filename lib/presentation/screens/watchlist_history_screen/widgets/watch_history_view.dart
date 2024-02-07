import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/watch_history/watch_history_bloc.dart';

class WatchHistoryViewWidget extends StatelessWidget {
  const WatchHistoryViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchHistoryBloc, WatchHistoryState>(
      builder: (context, state) {
        if (state.watchHistory.isEmpty) {
          return Expanded(
            child: Center(
              child: Lottie.asset(
                AppLottieAssets.emptyBox,
                backgroundLoading: true,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }

        return Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const WatchHistoryTileWidget(),
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.4,
              color: AppColors.grey,
            ),
            itemCount: 2,
          ),
        );
      },
    );
  }
}

class WatchHistoryTileWidget extends StatelessWidget {
  const WatchHistoryTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        children: [
          const Positioned.fill(
            child: SizedBox(
              width: double.infinity,
            ),
          ),
          Padding(
            padding: AppPadding.normalScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: context.screenWidth * 0.2,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                AppImageAssets.landgingBg,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: LinearProgressIndicator(
                                color: AppColors.red,
                                backgroundColor: AppColors.grey,
                                value: 0.75,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(W: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Itach Uchiha - The Legend of Village",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppFontSize.smallTitle,
                              fontWeight: AppFontWeight.bold,
                            ),
                          ),
                          const Gap(H: 5),
                          const Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.play_fill,
                                color: AppColors.indicator,
                                size: 18,
                              ),
                              Gap(W: 10),
                              Text(
                                "EP 148",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontWeight: AppFontWeight.normal,
                                  fontSize: AppFontSize.medium,
                                ),
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
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(H: 20),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 20,
                        children: List.generate(
                          ["Romance", "Action", "Adventure", "Fantasy"].length,
                          (index) => Container(
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(3)),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            child: Text(
                              [
                                "Romance",
                                "Action",
                                "Adventure",
                                "Fantasy"
                              ][index],
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: AppFontWeight.bold,
                                fontSize: AppFontSize.small,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(W: 10),
                    Container(
                      width: 25,
                      height: 25,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1,
                            color: AppColors.grey,
                          )),
                      child: const FittedBox(
                        child: Icon(
                          Icons.delete,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
