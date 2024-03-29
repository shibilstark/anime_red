import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/screens/home_screen/widgets/recent_release.dart';
import 'package:anime_red/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentReleasesExpandedView extends StatefulWidget {
  const RecentReleasesExpandedView({
    super.key,
  });

  @override
  State<RecentReleasesExpandedView> createState() =>
      _RecentReleasesExpandedViewState();
}

class _RecentReleasesExpandedViewState
    extends State<RecentReleasesExpandedView> {
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
    final currentState = context.read<RecentAnimeBloc>().state;

    if (currentState is RecentAnimeSuccess) {
      if (currentState.recentAnimes.hasNextPage && !currentState.isLoading) {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          context.read<RecentAnimeBloc>().add(const RecentAnimeAddNextPage());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentAnimeBloc, RecentAnimeState>(
      builder: (context, state) {
        if (state is RecentAnimeFailure) {
          return Center(
            child: AppErrorWidget(
              onTap: () {
                context
                    .read<RecentAnimeBloc>()
                    .add(const RecentAnimeLoadData());
              },
              errorMessage: state.message,
            ),
          );
        }
        if (state is RecentAnimeSuccess) {
          final recentAnimes = state.recentAnimes.datas;
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) =>
                        RecentReleaseTileWidget(anime: recentAnimes[index]),
                    itemCount: recentAnimes.length,
                  ),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            // shrinkWrap: true,
            itemBuilder: (context, index) =>
                const RecentAnimeLoadingTileWidget(),
            itemCount: 9,
          ),
        );
      },
    );
  }
}
