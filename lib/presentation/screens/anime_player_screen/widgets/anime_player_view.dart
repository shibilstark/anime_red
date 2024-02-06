import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class AnimePlayerView extends StatelessWidget {
  const AnimePlayerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: ShimmerWidget(
        width: double.infinity,
        radius: 0,
      ),
    );
  }
}
