import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TopAiringSliderWidget extends StatefulWidget {
  const TopAiringSliderWidget({
    super.key,
  });

  @override
  State<TopAiringSliderWidget> createState() => _TopAiringSliderWidgetState();
}

class _TopAiringSliderWidgetState extends State<TopAiringSliderWidget> {
  int activeIndex = 0;
  final carouselItemCount = 6;

  // Max 3
  final dummyGenres = [
    "Romance",
    "Action",
    "Adventure",
    "Comedy",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 3 / 3.5,
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: carouselItemCount,
                itemBuilder: (context, value, value2) {
                  return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 0.7,
                        image: AssetImage(
                          AppImageAssets.landgingBg,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  viewportFraction: 1,
                  aspectRatio: 3 / 3.5,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayInterval: const Duration(seconds: 10),
                ),
              ),
              Padding(
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
                    activeIndex: activeIndex,
                    count: carouselItemCount,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 600),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
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
                  "Itachi Uchiha: The Legend ${activeIndex + 1}",
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
                const Gap(H: 10),
                ThemeButtonWidget(
                  density: VisualDensity.comfortable,
                  minWidth: context.screenWidth * 0.4,
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      screenName: AppRouter.ANIME_PLAYER_SCREEN,
                    );
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
        ),
      ],
    );
  }
}
