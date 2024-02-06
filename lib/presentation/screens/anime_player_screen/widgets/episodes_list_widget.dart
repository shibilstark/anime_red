// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/models/start_end_model.dart';
import 'package:anime_red/presentation/widgets/custom_small_title_widget.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/anime/anime_bloc.dart';

class EpisodeListWidget extends StatefulWidget {
  const EpisodeListWidget({
    super.key,
    required this.scrollController,
    required this.playerMode,
    required this.anime,
    required this.startEnds,
    required this.currentPlayingEpisode,
  });
  final ValueNotifier<bool> playerMode;
  final ScrollController scrollController;
  final AnimeModel anime;
  final List<StartEndModel> startEnds;
  final String? currentPlayingEpisode;

  @override
  State<EpisodeListWidget> createState() => _EpisodeListWidgetState();
}

class _EpisodeListWidgetState extends State<EpisodeListWidget> {
  late final ValueNotifier<StartEndModel?> selectedSection;

  @override
  void initState() {
    selectedSection = ValueNotifier(
      widget.startEnds.isEmpty ? null : widget.startEnds.first,
      // null,
    );
    selectedSection.notifyListeners();
    super.initState();
  }

  @override
  void dispose() {
    selectedSection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.normalScreenPadding,
      child: ValueListenableBuilder(
          valueListenable: selectedSection,
          builder: (context, currentSection, _) {
            if (currentSection == null) {
              return const Column(
                children: [
                  Text(
                    "No Episode Datas Found or haven't released yet",
                    style: TextStyle(
                      color: AppColors.indicator,
                      fontSize: AppFontSize.medium,
                      fontWeight: AppFontWeight.normal,
                    ),
                  )
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomSmallTitleWidget(
                      title: "Episodes List",
                    ),
                    CorrentCollectionDropDownWidget(
                      widget: widget,
                      selectedSection: selectedSection,
                      currentSection: currentSection,
                    )
                  ],
                ),
                const Gap(H: 10),
                EpisodesGridWidget(
                  scrollController: widget.scrollController,
                  playerMode: widget.playerMode,
                  anime: widget.anime,
                  startEnds: widget.startEnds,
                  currentSection: currentSection,
                  currentPlayingEpisode: widget.currentPlayingEpisode,
                ),
              ],
            );
          }),
    );
  }
}

class EpisodesGridWidget extends StatelessWidget {
  const EpisodesGridWidget({
    super.key,
    required this.scrollController,
    required this.playerMode,
    required this.anime,
    required this.startEnds,
    required this.currentSection,
    required this.currentPlayingEpisode,
  });
  final ValueNotifier<bool> playerMode;
  final ScrollController scrollController;
  final AnimeModel anime;
  final List<StartEndModel> startEnds;
  final StartEndModel currentSection;
  final String? currentPlayingEpisode;

  @override
  Widget build(BuildContext context) {
    final showingAnimeList = anime.episodes
        .getRange(currentSection.start, currentSection.end + 1)
        .toList();
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        // childAspectRatio: 3 / 5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final thisEpisode = showingAnimeList[index];
        final isThisCurrentPlayingEpisode = currentPlayingEpisode != null &&
            thisEpisode.id == currentPlayingEpisode;

        return GestureDetector(
          onTap: () {
            playerMode.value = true;
            playerMode.notifyListeners();
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn);
            context.read<AnimeBloc>().add(AnimeGetEpisodeLink(thisEpisode.id));
            // log("episode Id = ${thisEpisode.id}");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                  color: isThisCurrentPlayingEpisode
                      ? AppColors.red
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: isThisCurrentPlayingEpisode
                        ? Colors.transparent
                        : AppColors.grey,
                  )),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    thisEpisode.episodeNumber.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppFontSize.small,
                      fontWeight: isThisCurrentPlayingEpisode
                          ? AppFontWeight.bold
                          : AppFontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: (currentSection.end - currentSection.start) + 1,
    );
  }
}

class CorrentCollectionDropDownWidget extends StatelessWidget {
  const CorrentCollectionDropDownWidget({
    super.key,
    required this.widget,
    required this.selectedSection,
    required this.currentSection,
  });

  final EpisodeListWidget widget;
  final ValueNotifier<StartEndModel?> selectedSection;
  final StartEndModel? currentSection;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: AppColors.grey,
            ),
          ),
          child: widget.startEnds.length <= 1
              ? const Gap()
              : DropdownButtonHideUnderline(
                  child: DropdownButton<StartEndModel>(
                    borderRadius: BorderRadius.circular(5),
                    value: currentSection,
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                    isDense: true,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.white,
                      size: 20,
                    ),
                    dropdownColor: AppColors.grey,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectedSection.value = newValue;
                      }

                      selectedSection.notifyListeners();
                    },
                    items: List.generate(
                      widget.startEnds.length,
                      (index) => DropdownMenuItem<StartEndModel>(
                        value: widget.startEnds[index],
                        child: Text(
                          "${widget.startEnds[index].start + 1} - ${widget.startEnds[index].end + 1}",
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
