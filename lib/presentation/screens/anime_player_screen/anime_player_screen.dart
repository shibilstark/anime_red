// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/anime_info.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                              isPlayerMode: isPlayerMode,
                            ),

                            AnimeInfoWidget(anime: state.anime),

                            //  NEED PADDING
                            AnimePlayButtonWidget(
                              playerMode: playerMode,
                              scrollController: _scrollController,
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

class AnimePlayButtonWidget extends StatelessWidget {
  const AnimePlayButtonWidget({
    super.key,
    required this.playerMode,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ValueNotifier<bool> playerMode;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return playerMode.value
        ? const Gap()
        : Padding(
            padding: AppPadding.normalScreenPadding,
            child: ThemeButtonWidget(
              density: VisualDensity.comfortable,
              minWidth: double.infinity,
              onTap: () {
                playerMode.value = !playerMode.value;
                playerMode.notifyListeners();
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Play",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bolder,
                      fontSize: AppFontSize.large,
                    ),
                  ),
                  Gap(W: 10),
                  Icon(
                    CupertinoIcons.play_fill,
                    color: AppColors.white,
                    size: 15,
                  )
                ],
              ),
            ),
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

class SimilarAnimeTileWidget extends StatelessWidget {
  const SimilarAnimeTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: AppPadding.normalScreenPadding,
            height: 100,
            // width: tileWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImageAssets.landgingBg,
                ),
              ),
            ),

            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 4,
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
            ),
          ),
        ),
        const Gap(H: 5),
        const Text(
          "Naruto Shippuden",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: AppFontWeight.bold,
            fontSize: AppFontSize.small,
          ),
        )
      ],
    );
  }
}
