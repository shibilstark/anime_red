import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/screens/search_screen/widgets/search_appbar.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/assets.dart';

final dummyGenres = [
  "Romance",
  "Action",
  "Adventure",
  "Comedy",
];

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.normalScreenPadding,
          child: Column(
            children: [
              const SearchAppBarWidget(),
              const Gap(H: 10),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomSmallTitleWidget(
                      title: "Top Airing",
                    ),
                    const Gap(H: 10),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          const SearchIdleTopAiringTileWidget(),
                      separatorBuilder: (context, index) => const Gap(H: 15),
                      itemCount: 4,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          const SearchResultTileWidget(),
                      itemCount: 5,
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResultTileWidget extends StatelessWidget {
  const SearchResultTileWidget({
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
                    fontSize: AppFontSize.medium,
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
            fontSize: AppFontSize.large,
          ),
        )
      ],
    );
  }
}

class SearchIdleTopAiringTileWidget extends StatelessWidget {
  const SearchIdleTopAiringTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.black,
          image: const DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.6,
            image: AssetImage(
              AppImageAssets.landgingBg,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceIn,
            padding: AppPadding.normalScreenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Itachi Uchiha: The Legend",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
      ),
    );
  }
}
