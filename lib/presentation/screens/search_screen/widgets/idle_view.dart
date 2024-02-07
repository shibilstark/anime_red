import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/bloc/home/home_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenIdleViewWidget extends StatelessWidget {
  const SearchScreenIdleViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSmallTitleWidget(
                title: "Top Airing",
              ),
              const Gap(H: 10),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      SearchIdleTopAiringTileWidget(
                          anime: state.topAnimes.datas[index]),
                  separatorBuilder: (context, index) => const Gap(H: 15),
                  itemCount: state.topAnimes.datas.length,
                ),
              ),
            ],
          ));
        }

        return const SearchResltIdleShimmerWidget();
      },
    );
  }
}

class SearchIdleTopAiringTileWidget extends StatelessWidget {
  const SearchIdleTopAiringTileWidget({
    super.key,
    required this.anime,
  });

  final TopAiringModel anime;

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
      child: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: NetWorkImageWidget(
                    image: anime.image,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(
                    0.6,
                  )),
                ),
              ],
            ),
          ),

          //
          //
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              width: double.infinity,
              duration: const Duration(milliseconds: 500),
              curve: Curves.bounceIn,
              padding: AppPadding.normalScreenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(H: 100),
                  Text(
                    anime.title,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bolder,
                      fontSize: AppFontSize.largeTitle,
                    ),
                  ),
                  const Gap(H: 5),
                  Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: List.generate(
                      anime.genres.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(3)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        child: Text(
                          anime.genres[index],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: AppFontWeight.bold,
                            fontSize: AppFontSize.small,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResltIdleShimmerWidget extends StatelessWidget {
  const SearchResltIdleShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget(
            height: 12,
            width: 100,
          ),
          const Gap(H: 10),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const AspectRatio(
                aspectRatio: 2 / 1,
                child: ShimmerWidget(
                  width: double.infinity,
                ),
              ),
              separatorBuilder: (context, index) => const Gap(H: 15),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
