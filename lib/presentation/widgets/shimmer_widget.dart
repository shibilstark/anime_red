import 'package:anime_red/config/config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {Key? key,
      this.isRound = false,
      this.height = 0,
      this.width = 0,
      this.radius = 5})
      : super(key: key);

  final bool isRound;
  final double radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        enabled: true,
        highlightColor: AppColors.grey,
        period: const Duration(seconds: 2),
        baseColor: AppColors.black,
        child: isRound
            ? CircleAvatar(
                backgroundColor: AppColors.black,
                radius: radius,
              )
            : ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  ),
                  height: height,
                  width: width,
                ),
              ));
  }
}
