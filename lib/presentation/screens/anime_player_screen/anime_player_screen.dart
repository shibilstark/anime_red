// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/start_end_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/anime_info.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/play_button.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_small_title_widget.dart';
import '../../widgets/error_widget.dart';

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

                    // DONT NEED PADDING

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

                            AnimeInfoWidget(anime: state.anime),

                            //  NEED PADDING
                            AnimePlayButtonWidget(
                              playerMode: playerMode,
                              scrollController: _scrollController,
                              isShowing: state.startEndList.isNotEmpty,
                            ),

                            EpisodeListWidget(
                              anime: state.anime,
                              playerMode: playerMode,
                              scrollController: _scrollController,
                              startEnds: state.startEndList,
                            ),
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

class EpisodeListWidget extends StatefulWidget {
  const EpisodeListWidget({
    super.key,
    required this.scrollController,
    required this.playerMode,
    required this.anime,
    required this.startEnds,
  });
  final ValueNotifier<bool> playerMode;
  final ScrollController scrollController;
  final AnimeModel anime;
  final List<StartEndModel> startEnds;

  @override
  State<EpisodeListWidget> createState() => _EpisodeListWidgetState();
}

// Key = 1-100 Value 1-100 Episode Ids

class _EpisodeListWidgetState extends State<EpisodeListWidget> {
  late final ValueNotifier<StartEndModel?> selectedSection;

  @override
  void initState() {
    selectedSection = ValueNotifier(
      widget.startEnds.isEmpty ? null : widget.startEnds.first,
      // null,
    );
    selectedSection.notifyListeners();
    super.initState();
  }

  @override
  void dispose() {
    selectedSection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.normalScreenPadding,
      child: ValueListenableBuilder(
          valueListenable: selectedSection,
          builder: (context, currentSection, _) {
            if (currentSection == null) {
              return const Column(
                children: [
                  Text(
                    "No Episode Datas Found or haven't released yet",
                    style: TextStyle(
                      color: AppColors.indicator,
                      fontSize: AppFontSize.medium,
                      fontWeight: AppFontWeight.normal,
                    ),
                  )
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomSmallTitleWidget(
                      title: "Episodes List",
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: AppColors.grey,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            for (final element in widget.startEnds) {
                              log(element.toString());
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 15),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "1-100",
                                    style: TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  Gap(W: 3),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(H: 10),
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.anime.episodes[index].episodeNumber
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: AppFontSize.small,
                              fontWeight: AppFontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: widget.anime.episodes.length >= 100
                      ? 100
                      : widget.anime.episodes.length,
                ),
              ],
            );
          }),
    );
  }
}

class AnimePlayerWidget extends StatefulWidget {
  const AnimePlayerWidget({
    super.key,
    required this.isPlayerMode,
  });
  final bool isPlayerMode;

  @override
  State<AnimePlayerWidget> createState() => _AnimePlayerWidgetState();
}

class _AnimePlayerWidgetState extends State<AnimePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isPlayerMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(H: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColors.grey,
                ),
              ),
              const Gap(H: 40),
            ],
          )
        : const SizedBox();
  }
}
