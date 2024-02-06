import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/screens/genre_search_screen/widget/recent_releease_view.dart';
import 'package:anime_red/presentation/widgets/appbar_text.dart';
import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';

enum GenreScreenType {
  genre,
  recentEpisodes,
}

class GenreScreen extends StatefulWidget {
  final GenreScreenType type;
  const GenreScreen({
    super.key,
    required this.type,
  });

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.normalScreenPadding,
          child: Column(
            children: [
              Row(
                children: [
                  const CommonBackButtonWidget(),
                  const Gap(W: 10),
                  AppBarTitleTextWidget(
                    title: widget.type == GenreScreenType.recentEpisodes
                        ? "Recent Releases"
                        : "Romance",
                  ),
                ],
              ),
              const Gap(H: 10),
              widget.type == GenreScreenType.recentEpisodes
                  ? const RecentReleasesExpandedView()
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 3 / 5,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            const SearchByGenreTileWidget(),
                        itemCount: 5,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchByGenreTileWidget extends StatelessWidget {
  const SearchByGenreTileWidget({
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
            fontSize: AppFontSize.verySmall,
          ),
        )
      ],
    );
  }
}
