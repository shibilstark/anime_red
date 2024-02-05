import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class SearchResultShimmerWidget extends StatelessWidget {
  const SearchResultShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => const ShimmerWidget(
        width: double.infinity,
      ),
      itemCount: 6,
    );
  }
}
