import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/screens/home_screen/widgets/recent_release.dart';
import 'package:anime_red/presentation/widgets/custom_circular_indicator.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentReleasesExpandedView extends StatelessWidget {
  const RecentReleasesExpandedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentAnimeBloc, RecentAnimeState>(
      builder: (context, state) {
        if (state is RecentAnimeSuccess) {
          final recentAnimes = state.recentAnimes.datas;
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    // shrinkWrap: true,
                    itemBuilder: (context, index) => index ==
                            recentAnimes.length
                        ? Builder(builder: (context) {
                            if (state.recentAnimes.hasNextPage &&
                                !state.isLoading) {
                              context
                                  .read<RecentAnimeBloc>()
                                  .add(const RecentAnimeAddNextPage());
                            }
                            return const SizedBox();
                          })
                        : RecentReleaseTileWidget(anime: recentAnimes[index]),
                    itemCount: recentAnimes.length + 1,
                  ),
                ),
                state.isLoading
                    ? const CustomCircularIndicatorWidget()
                    : const Gap()
              ],
            ),
          );
        }

        return const RecentAnimeLoadingBuilderWidget();
      },
    );
  }
}
