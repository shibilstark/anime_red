import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';

class AnimePlayerWidget extends StatefulWidget {
  const AnimePlayerWidget({
    super.key,
    required this.isPlayerMode,
  });
  final bool isPlayerMode;

  @override
  State<AnimePlayerWidget> createState() => _AnimePlayerWidgetState();
}

class _AnimePlayerWidgetState extends State<AnimePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isPlayerMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(H: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColors.grey,
                ),
              ),
              const Gap(H: 40),
            ],
          )
        : const SizedBox();
  }
}
