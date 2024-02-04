import 'dart:ui';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimePlayerScreen extends StatefulWidget {
  const AnimePlayerScreen({super.key});

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
                    const Padding(
                      padding: AppPadding.normalScreenPadding,
                      child: Row(
                        children: [
                          CommonBackButtonWidget(),
                          Gap(W: 10),
                          AppBarTitleTextWidget(
                            title: "Naruto Shippuden",
                          ),
                        ],
                      ),
                    ),
                    const Gap(H: 10),

                    // DONT NEED PADDING

                    AnimePlayerWidget(
                      isPlayerMode: isPlayerMode,
                    ),

                    const AnimeInfoWidget(),

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
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.normalScreenPadding.left,
                      ),
                      child: const Column(
                        children: [
                          CustomSmallTitleWidget(title: "Similar Animes"),
                        ],
                      ),
                    ),
                    const Gap(H: 10),

                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          const SimilarAnimeTileWidget(),
                      itemCount: 10,
                    )
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
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        MovieInfoBackgroundWidget(),
        AnimeInfoForegroundWidget(),
      ],
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
  });

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
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AppImageAssets.landgingBg,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(W: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Itachi Uchiha: The Legend & The Shadow Assassin",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
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
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              dummyGenres.length,
              (index) => Container(
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(3)),
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 6,
                ),
                child: Text(
                  dummyGenres[index],
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
            child: const Text(
              "Explore the world of Anime, You can stream thousands of Anime at AnimeRED for free Explore the world of Anime, You can stream thousands of Anime at AnimeRED for free ",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: AppFontWeight.medium,
                fontSize: AppFontSize.small,
              ),
            ),
          ),
          const Gap(H: 10),
          const AnimeInfoKeyValuePairWidget(
            titleKey: "Alternative Name:",
            value: "The Legend of Uchiha, The Shadoe of Salamandar",
          ),
          const Gap(H: 5),
          const AnimeInfoKeyValuePairWidget(
            titleKey: "Release Date: ",
            value: "13/10/2023",
          ),
          const Gap(H: 5),
          const AnimeInfoKeyValuePairWidget(
            titleKey: "Alternative Name:",
            value: "The Legend of Uchiha, The Shadoe of Salamandar",
          ),
          const Gap(H: 15),
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
              color: AppColors.white,
              fontWeight: AppFontWeight.bold,
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
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AppImageAssets.landgingBg,
            ),
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ),
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
