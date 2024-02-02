import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchAndBookMarkWidget extends StatelessWidget {
  const HomeSearchAndBookMarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: AppColors.grey,
                  size: 15,
                ),
                Gap(W: 10),
                Text(
                  "Search anime...",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: AppFontWeight.bold,
                    fontSize: AppFontSize.medium,
                  ),
                ),
              ],
            ),
          ),
        )),
        const Gap(W: 10),
        const Column(
          children: [
            Icon(
              Icons.bookmark_outline_rounded,
              color: AppColors.white,
              size: 25,
            ),
            Gap(H: 2),
            Text(
              "Bookmarks",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: AppFontWeight.bolder,
                fontSize: AppFontSize.verySmall,
              ),
            ),
          ],
        )
      ],
    );
  }
}
