import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
    return AspectRatio(
      aspectRatio: 3 / 4,
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
              aspectRatio: 3 / 4,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15),
              color: AppColors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceIn,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            spacing: 10,
                            runSpacing: 20,
                            children: List.generate(
                              dummyGenres.length,
                              (index) => Container(
                                decoration: BoxDecoration(
                                    color: AppColors.red,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.play_fill,
                    color: AppColors.white,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
