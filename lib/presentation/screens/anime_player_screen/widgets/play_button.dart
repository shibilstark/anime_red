// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/anime/anime_bloc.dart';

class AnimePlayButtonWidget extends StatelessWidget {
  const AnimePlayButtonWidget({
    super.key,
    required this.playerMode,
    required this.isShowing,
    required ScrollController scrollController,
    required this.animeId,
  }) : _scrollController = scrollController;

  final ValueNotifier<bool> playerMode;
  final ScrollController _scrollController;

  final bool isShowing;
  final String animeId;

  @override
  Widget build(BuildContext context) {
    return playerMode.value
        ? const Gap()
        : isShowing
            ? Padding(
                padding: AppPadding.normalScreenPadding,
                child: ThemeButtonWidget(
                  density: VisualDensity.comfortable,
                  minWidth: double.infinity,
                  onTap: () {
                    playerMode.value = !playerMode.value;
                    playerMode.notifyListeners();
                    context
                        .read<AnimeBloc>()
                        .add(AnimePlayLastPlayedEpisode(animeId));
                    _scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Continue Watching",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: AppFontWeight.bolder,
                          fontSize: AppFontSize.large,
                        ),
                      ),
                      Gap(W: 10),
                      Icon(
                        CupertinoIcons.play_fill,
                        color: AppColors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              )
            : const Gap();
  }
}
