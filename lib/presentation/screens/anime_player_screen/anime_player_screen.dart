// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/anime_info.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/episodes_list_widget.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/play_button.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/watchlist_button.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/error_widget.dart';
import 'widgets/anime_player_widget.dart';

class AnimePlayerScreen extends StatefulWidget {
  const AnimePlayerScreen({
    super.key,
    required this.animeId,
    required this.animeTitle,
  });
  final String animeId;

  final String animeTitle;

  @override
  State<AnimePlayerScreen> createState() => _AnimePlayerScreenState();
}

class _AnimePlayerScreenState extends State<AnimePlayerScreen> {
  late final ValueNotifier<bool> playerMode;

  late final ScrollController _scrollController;
  @override
  void initState() {
    playerMode = ValueNotifier(false);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    playerMode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ValueListenableBuilder(
              valueListenable: playerMode,
              builder: (context, isPlayerMode, _) {
                return Column(
                  children: [
                    // AppBar
                    Padding(
                      padding: AppPadding.normalScreenPadding,
                      child: Row(
                        children: [
                          const CommonBackButtonWidget(),
                          const Gap(W: 10),
                          Expanded(
                            child: AppBarTitleTextWidget(
                              title: widget.animeTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(H: 10),

                    // BODY
                    BlocBuilder<AnimeBloc, AnimeState>(
                        builder: (context, state) {
                      if (state is AnimeFailure) {
                        return Center(
                          child: AppErrorWidget(
                            errorMessage: state.message,
                            onTap: () {
                              context
                                  .read<AnimeBloc>()
                                  .add(AnimeGetInfo(widget.animeId));
                            },
                          ),
                        );
                      }

                      if (state is AnimeSuccess) {
                        return Column(
                          children: [
                            AnimePlayerWidget(
                              isPlayerMode: playerMode.value,
                            ),
                            isPlayerMode
                                ? EpisodeListWidget(
                                    anime: state.anime,
                                    playerMode: playerMode,
                                    scrollController: _scrollController,
                                    startEnds: state.startEndList,
                                    currentPlayingEpisode:
                                        state.currentPlayingEpisodeId,
                                  )
                                : const Gap(),
                            const Gap(H: 10),
                            AnimeInfoWidget(anime: state.anime),
                            const Gap(H: 10),
                            Padding(
                              padding: AppPadding.normalScreenPadding,
                              child: WatchListButtonWidget(anime: state.anime),
                            ),
                            AnimePlayButtonWidget(
                              playerMode: playerMode,
                              scrollController: _scrollController,
                              isShowing: state.startEndList.isNotEmpty,
                            ),
                            !isPlayerMode
                                ? EpisodeListWidget(
                                    anime: state.anime,
                                    playerMode: playerMode,
                                    scrollController: _scrollController,
                                    startEnds: state.startEndList,
                                    currentPlayingEpisode:
                                        state.currentPlayingEpisodeId,
                                  )
                                : const Gap(),
                          ],
                        );
                      }

                      return const AnimeInfoShimmerWidget();
                    }),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class EpisodeListShimmerWidget extends StatelessWidget {
  const EpisodeListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.normalScreenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget(
            height: 12,
            width: 100,
          ),
          const Gap(H: 15),
          GridView.builder(
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              // childAspectRatio: 3 / 5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: AppColors.grey,
                    )),
                child: const ShimmerWidget(),
              ),
            ),
            itemCount: 50,
          ),
        ],
      ),
    );
  }
}
