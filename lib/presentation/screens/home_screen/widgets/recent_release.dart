import 'package:anime_red/config/config.dart';
import 'package:anime_red/config/constants/assets.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeRecentReleaseWidget extends StatelessWidget {
  const HomeRecentReleaseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomSmallTitleWIdget(
          title: "Recently Released",
        ),
        const Gap(H: 10),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
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
              const Column(
                children: [
                  Text(
                    "Naruto Shippuden",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppFontSize.large,
                    ),
                  ),
                  Gap(W: 10),
                  Text(
                    "EP 148",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.red,
                      fontWeight: AppFontWeight.normal,
                      fontSize: AppFontSize.medium,
                    ),
                  ),
                ],
              )
            ],
          ),
          itemCount: 5,
        )
      ],
    );
  }
}
