// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/screens/search_screen/widgets/idle_view.dart';
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

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController textController;
  late final FocusNode focusNode;

  @override
  void initState() {
    textController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.normalScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAppBarWidget(
                controller: textController,
                node: focusNode,
                onChanged: (text) {
                  if (text.trim().isEmpty) {
                    focusNode.unfocus();
                  }
                  textController.notifyListeners();
                },
              ),
              const Gap(H: 10),
              ValueListenableBuilder(
                  valueListenable: textController,
                  builder: (context, text, child) {
                    if (text.text.trim().isEmpty) {
                      return const SearchScreenIdleViewWidget();
                    } else {
                      return const SearchScreenResultViewWidget();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreenResultViewWidget extends StatelessWidget {
  const SearchScreenResultViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSmallTitleWidget(
          title: "Top Airing",
        ),
        const Gap(H: 10),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const SearchResultTileWidget(),
            itemCount: 2,
          ),
        ),
      ],
    ));
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
