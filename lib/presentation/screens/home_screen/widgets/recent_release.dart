import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/models/recent_episode_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recent_anime/recent_anime_bloc.dart';

class HomeRecentReleaseWidget extends StatelessWidget {
  const HomeRecentReleaseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentAnimeBloc, RecentAnimeState>(
      builder: (context, state) {
        if (state is RecentAnimeSuccess) {
          final animesToShow = state.recentAnimes.datas.take(10).toList();
          return Column(
            children: [
              const CustomSmallTitleWidget(
                title: "Recently Released",
              ),
              const Gap(H: 10),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 25,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => index == animesToShow.length
                    ? GestureDetector(
                        onTap: () {
                          AppNavigator.push(
                              context: context,
                              screenName: AppRouter.RECENT_EPISODES_SCREEN);
                        },
                        child: Container(
                          padding: AppPadding.normalScreenPadding,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.grey,
                              ),
                              Gap(H: 10),
                              Text(
                                "See More",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: AppFontSize.medium,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : RecentReleaseTileWidget(
                        anime: animesToShow[index],
                      ),
                itemCount: animesToShow.length + 1,
              ),
            ],
          );
        }

        return const RecentAnimeLoadingBuilderWidget();
      },
    );
  }
}

class RecentAnimeLoadingBuilderWidget extends StatelessWidget {
  const RecentAnimeLoadingBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerWidget(
          height: 12,
          width: 100,
        ),
        const Gap(H: 10),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => const RecentAnimeLoadingTileWidget(),
          itemCount: 3,
        ),
      ],
    );
  }
}

class RecentAnimeLoadingTileWidget extends StatelessWidget {
  const RecentAnimeLoadingTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: ShimmerWidget(
            height: 100,
            width: double.infinity,
          ),
        ),
        Gap(H: 5),
        ShimmerWidget(
          height: 15,
          width: double.infinity,
        ),
      ],
    );
  }
}

class RecentReleaseTileWidget extends StatelessWidget {
  const RecentReleaseTileWidget({
    super.key,
    required this.anime,
  });

  final RecentEpisodeModel anime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AnimeBloc>().add(AnimeGetInfo(anime.id));

        AppNavigator.push(
            context: context,
            screenName: AppRouter.ANIME_PLAYER_SCREEN,
            arguments: {"args": (anime.id, anime.title)});
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: NetWorkImageWidget(
                image: anime.image,
              ),
            ),
          ),
          const Gap(H: 5),
          Column(
            children: [
              Text(
                anime.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: AppFontWeight.bold,
                  fontSize: AppFontSize.small,
                ),
              ),
              const Gap(W: 10),
              Text(
                "EP ${anime.episodeNumber}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.red,
                  fontWeight: AppFontWeight.normal,
                  fontSize: AppFontSize.small,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
