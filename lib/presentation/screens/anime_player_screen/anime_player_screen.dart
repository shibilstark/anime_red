// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:ui';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

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
                            Padding(
                              padding: AppPadding.normalScreenPadding,
                              child: ThemeButtonWidget(
                                density: VisualDensity.comfortable,
                                minWidth: double.infinity,
                                onTap: () {
                                  playerMode.value = !isPlayerMode;
                                  playerMode.notifyListeners();
                                  _scrollController.animateTo(0,
                                      duration:
                                          const Duration(milliseconds: 400),
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

class AnimeInfoWidget extends StatelessWidget {
  const AnimeInfoWidget({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovieInfoBackgroundWidget(image: anime.image),
        AnimeInfoForegroundWidget(anime: anime),
      ],
    );
  }
}

class AnimeInfoShimmerWidget extends StatelessWidget {
  const AnimeInfoShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.normalScreenPadding,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.screenWidth * 0.25,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const ShimmerWidget(),
                  ),
                ),
              ),
              const Gap(W: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(
                      height: 30,
                      width: context.screenWidth * 0.5,
                    ),
                    const Gap(H: 10),
                    const ShimmerWidget(
                      height: 20,
                      width: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(H: 20),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                3,
                (index) => ShimmerWidget(
                      height: 20,
                      width: context.screenWidth * 0.2,
                    )),
          ),
          const Gap(H: 15),
          const ShimmerWidget(
            width: double.infinity,
            height: 40,
          ),
          const Gap(H: 10),
        ],
      ),
    );
  }
}

final dummyGenres = [
  "Romance",
  "Action",
  "Adventure",
  "Comedy",
  "Romance",
];

class AnimeInfoForegroundWidget extends StatelessWidget {
  const AnimeInfoForegroundWidget({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.normalScreenPadding,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.screenWidth * 0.25,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.grey,
                        ),
                      ),
                      child: NetWorkImageWidget(image: anime.image),
                    ),
                  ),
                ),
              ),
              const Gap(W: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFontWeight.bolder,
                        fontSize: AppFontSize.largeTitle,
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
                      child: Text(
                        anime.subOrDub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
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
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              anime.genres.length,
              (index) => Container(
                decoration: BoxDecoration(
                    color: AppColors.grey,
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
          ),
          const Gap(H: 15),

          Container(
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  )),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: ReadMoreText(
                anime.description ?? "No Description Found",
                trimLines: 3,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppFontSize.small,
                ),
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                moreStyle: const TextStyle(
                  fontSize: AppFontSize.small,
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.indicator,
                ),
              )),
          const Gap(H: 10),

          AnimeInfoKeyValuePairWidget(
            titleKey: "Alternative Name:",
            value: anime.otherName,
          ),
          const Gap(H: 5),
          AnimeInfoKeyValuePairWidget(
            titleKey: "No of Episodes",
            value: anime.episodeCount.toString(),
          ),
          const Gap(H: 5),
          AnimeInfoKeyValuePairWidget(
            titleKey: "Status",
            value: anime.status,
          ),
          const Gap(H: 5),
          AnimeInfoKeyValuePairWidget(
            titleKey: "Release Date: ",
            value: anime.releaseDate ?? "Not Available",
          ),
          const Gap(H: 5),
          AnimeInfoKeyValuePairWidget(
            titleKey: "Type",
            value: anime.type ?? "Not Available",
          ),

          const Gap(H: 15),

          /// TODO WATCHLIST FUNCTIONALITY
          // INACTIVE
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  )),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    size: 15,
                    color: AppColors.white,
                  ),
                  Gap(W: 5),
                  FittedBox(
                    child: Text(
                      "Add to Watchlist",
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: AppColors.white,
                        fontWeight: AppFontWeight.medium,
                        fontSize: AppFontSize.small,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(H: 10),
          // ACTIVE
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  )),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    size: 15,
                    color: AppColors.white,
                  ),
                  Gap(W: 5),
                  FittedBox(
                    child: Text(
                      "Edit Watchlist",
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: AppColors.white,
                        fontWeight: AppFontWeight.medium,
                        fontSize: AppFontSize.small,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimeInfoKeyValuePairWidget extends StatelessWidget {
  const AnimeInfoKeyValuePairWidget({
    super.key,
    required this.titleKey,
    required this.value,
  });

  final String titleKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleKey,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.8),
            fontWeight: AppFontWeight.normal,
            fontSize: AppFontSize.small,
          ),
        ),
        const Gap(W: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.indicator,
              fontWeight: AppFontWeight.normal,
              fontSize: AppFontSize.small,
            ),
          ),
        )
      ],
    );
  }
}

class MovieInfoBackgroundWidget extends StatelessWidget {
  const MovieInfoBackgroundWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: NetWorkImageWidget(image: image),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
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
