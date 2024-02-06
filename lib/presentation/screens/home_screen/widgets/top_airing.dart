// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/domain/models/top_airing_model.dart';
import 'package:anime_red/presentation/bloc/anime/anime_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../bloc/home/home_bloc.dart';

class TopAiringSliderWidget extends StatefulWidget {
  const TopAiringSliderWidget({
    super.key,
  });

  @override
  State<TopAiringSliderWidget> createState() => _TopAiringSliderWidgetState();
}

class _TopAiringSliderWidgetState extends State<TopAiringSliderWidget> {
  late ValueNotifier<int> activeIndex;

  @override
  void initState() {
    activeIndex = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          final animes = state.topAnimes.datas.take(10).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3 / 3.5,
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: animes.length,
                      itemBuilder: (context, index, pageIndex) {
                        return SizedBox(
                          width: double.infinity,
                          child: NetWorkImageWidget(
                            image: animes[index].image,
                            // TODO ADD PLACEHOLDER?ERRORBUILDER
                          ),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          activeIndex.value = index;
                          activeIndex.notifyListeners();
                        },
                        viewportFraction: 1,
                        aspectRatio: 3 / 3.5,
                        autoPlay: true,
                        autoPlayCurve: Curves.easeIn,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        autoPlayInterval: const Duration(seconds: 10),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: activeIndex,
                        builder: (context, index, _) {
                          return Padding(
                            padding: AppPadding.normalScreenPadding,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: AnimatedSmoothIndicator(
                                effect: const ExpandingDotsEffect(
                                  spacing: 5,
                                  dotColor: AppColors.white,
                                  activeDotColor: AppColors.red,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                ),
                                activeIndex: index,
                                count: animes.length,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 600),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: activeIndex,
                  builder: (context, index, _) {
                    return TopAiringTitlesWidget(
                      anime: animes[index],
                    );
                  }),
            ],
          );
        }

        return const TopAiringLoadingShimmerWidget();
      },
    );
  }
}

class TopAiringTitlesWidget extends StatelessWidget {
  const TopAiringTitlesWidget({
    super.key,
    required this.anime,
  });

  final TopAiringModel anime;

  @override
  Widget build(BuildContext context) {
    final shortedGenres = anime.genres.take(4).toList();
    return Container(
      padding: const EdgeInsets.all(15),
      color: AppColors.black.withOpacity(0.5),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.bounceIn,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              anime.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: AppFontWeight.bolder,
                fontSize: AppFontSize.largeTitle,
              ),
            ),
            const Gap(H: 5),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                shortedGenres.length,
                (index) => Container(
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(3)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 6,
                  ),
                  child: Text(
                    shortedGenres[index],
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppFontSize.small,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(H: 10),
            ThemeButtonWidget(
              density: VisualDensity.comfortable,
              minWidth: context.screenWidth * 0.4,
              onTap: () {
                context.read<AnimeBloc>().add(AnimeGetInfo(anime.id));

                AppNavigator.push(
                    context: context,
                    screenName: AppRouter.ANIME_PLAYER_SCREEN,
                    arguments: {"args": (anime.id, anime.title)});
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Watch",
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
            )
          ],
        ),
      ),
    );
  }
}

class TopAiringLoadingShimmerWidget extends StatelessWidget {
  const TopAiringLoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3 / 3.5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.black,
            ),
            child: Lottie.asset(
              AppLottieAssets.loadingText,
              backgroundLoading: true,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          color: AppColors.black.withOpacity(0.5),
          child: Column(
            children: [
              ShimmerWidget(
                height: 30,
                width: screenWidth * 0.6,
              ),
              const Gap(H: 5),
            ],
          ),
        ),
        const Gap(H: 5),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            3,
            (index) => ShimmerWidget(
              height: 18,
              width: screenWidth * 0.25,
            ),
          ),
        ),
        const Gap(H: 10),
        ShimmerWidget(
          height: 30,
          width: context.screenWidth * 0.4,
        ),
      ],
    );
  }
}
