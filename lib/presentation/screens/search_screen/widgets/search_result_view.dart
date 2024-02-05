// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/models/search_result_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/bloc/anime_search/anime_search_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/error_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenResultViewWidget extends StatefulWidget {
  const SearchScreenResultViewWidget({
    super.key,
    required this.queryController,
  });

  final TextEditingController queryController;

  @override
  State<SearchScreenResultViewWidget> createState() =>
      _SearchScreenResultViewWidgetState();
}

class _SearchScreenResultViewWidgetState
    extends State<SearchScreenResultViewWidget> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_nextPageLoader);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_nextPageLoader);
    scrollController.dispose();
    super.dispose();
  }

  _nextPageLoader() {
    final currentState = context.read<AnimeSearchBloc>().state;

    if (currentState is AnimeSearchSuccess) {
      if (currentState.searchResults.hasNextPage && !currentState.isLoading) {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          context
              .read<AnimeSearchBloc>()
              .add(AnimeSearchAddNextPage(widget.queryController.text.trim()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
      builder: (context, state) {
        if (state is AnimeSearchSuccess) {
          if (state.searchResults.datas.isEmpty) {
            return const Expanded(
                child: Center(
              child: Text(
                "Seems like nothing found, modify your keyword or search somthing else",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppFontSize.medium,
                ),
              ),
            ));
          }

          return Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSmallTitleWidget(
                title: "Search Results",
              ),
              const Gap(H: 10),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 5,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) => SearchResultTileWidget(
                            anime: state.searchResults.datas[index]),
                        itemCount: state.searchResults.datas.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
        }

        if (state is AnimeSearchFailure) {
          return Center(
            child: AppErrorWidget(
              onTap: () {
                // final Debouncer debouncer = Debouncer();
                context.read<AnimeSearchBloc>().add(
                      AnimeSearchQuery(widget.queryController.text.trim()),
                    );
              },
              errorMessage: state.message,
            ),
          );
        }

        return const SearchResultShimmerWidget();
      },
    );
  }
}

class SearchResultTileWidget extends StatelessWidget {
  const SearchResultTileWidget({
    super.key,
    required this.anime,
  });
  final SearchResultModel anime;
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
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: NetWorkImageWidget(
                    image: anime.image,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: AppPadding.normalScreenPadding,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.white,
                      ),
                      child: Text(
                        anime.subOrDub.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.red,
                          fontWeight: AppFontWeight.bolder,
                          fontSize: AppFontSize.medium,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(H: 5),
          Text(
            anime.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: AppFontWeight.bold,
              fontSize: AppFontSize.medium,
            ),
          )
        ],
      ),
    );
  }
}

class SearchResultShimmerWidget extends StatelessWidget {
  const SearchResultShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => const ShimmerWidget(
          width: double.infinity,
        ),
        itemCount: 8,
      ),
    );
  }
}
