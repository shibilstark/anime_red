import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/anime/anime_bloc.dart';

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
        ? BlocBuilder<AnimeBloc, AnimeState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(H: 10),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: AppColors.grey,
                    ),
                  ),
                  const Gap(H: 10),
                  PlayerOptionsWidget(
                    onTap: (index) {},
                    title: "Quality",
                    options: const [
                      "1080p",
                      "720p",
                      "480p",
                      "360p",
                    ],
                  ),
                  const Gap(H: 10),
                  PlayerOptionsWidget(
                    onTap: (index) {},
                    title: "Server",
                    options: const [
                      "gogocdn",
                      "vidstream",
                      "streamsb",
                    ],
                  ),
                ],
              );
            },
          )
        : const SizedBox();
  }
}

class PlayerOptionsWidget extends StatelessWidget {
  const PlayerOptionsWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.options,
  });

  final String title;
  final List<String> options;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppPadding.normalScreenPadding.left),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: AppFontSize.small,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          const Gap(W: 10),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                options.length,
                (index) => GestureDetector(
                  onTap: () {
                    onTap(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(3)),
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    child: Text(
                      options[index],
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: AppFontWeight.bold,
                        fontSize: AppFontSize.small,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
