import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/models/anime_model.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/watch_list/watch_list_bloc.dart';

class WatchListButtonWidget extends StatelessWidget {
  const WatchListButtonWidget({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchListBloc, WatchListState>(
      builder: (context, state) {
        final isThisAddedToWatchList =
            state.watchList.any((element) => element.id == anime.id);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isThisAddedToWatchList
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<WatchListBloc>()
                          .add(WatchListRemoveItem(anime.id));
                    },
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.red,
                      size: 25,
                    ),
                  )
                : const Gap(),
            const Gap(W: 15),
            GestureDetector(
              onTap: () {
                WatchListType? currentType;

                try {
                  currentType = state.watchList
                      .firstWhere((element) => element.id == anime.id)
                      .watchListType;
                } catch (e) {
                  currentType = null;
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    contentPadding: AppPadding.normalScreenPadding,
                    content: SelectWatchlistDialogWidget(
                      onTap: (newWatchlistType) {
                        if (isThisAddedToWatchList) {
                          context.read<WatchListBloc>().add(WatchListUpdateType(
                              id: anime.id, type: newWatchlistType));
                        } else {
                          context
                              .read<WatchListBloc>()
                              .add(WatchListAddNew(WatchListModel(
                                id: anime.id,
                                title: anime.title,
                                image: anime.image,
                                genres: anime.genres,
                                subOrDub: anime.subOrDub,
                                type: anime.type ?? "N/A",
                                watchListType: newWatchlistType,
                                description: anime.description,
                              )));
                        }
                      },
                      currentType: currentType,
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.grey,
                        width: 1,
                      )),
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: isThisAddedToWatchList ? 12 : 10,
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isThisAddedToWatchList
                              ? Icons.edit_note_rounded
                              : CupertinoIcons.add,
                          size: 15,
                          color: AppColors.white,
                        ),
                        const Gap(W: 5),
                        FittedBox(
                          child: Text(
                            isThisAddedToWatchList
                                ? "Edit Watchlist"
                                : "Add to Watchlist",
                            style: const TextStyle(
                              overflow: TextOverflow.clip,
                              color: AppColors.white,
                              fontWeight: AppFontWeight.medium,
                              fontSize: AppFontSize.small,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }
}

class SelectWatchlistDialogWidget extends StatelessWidget {
  const SelectWatchlistDialogWidget({
    super.key,
    required this.onTap,
    required this.currentType,
  });

  final void Function(WatchListType type) onTap;
  final WatchListType? currentType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              WatchListType.values.length,
              (index) => Padding(
                    padding: AppPadding.normalScreenPadding,
                    child: GestureDetector(
                      onTap: () {
                        onTap.call(WatchListType.values[index]);
                        AppNavigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: currentType != null &&
                                      currentType == WatchListType.values[index]
                                  ? AppColors.indicator
                                  : AppColors.silver,
                            )),
                        padding: AppPadding.normalScreenPadding,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                WatchListType.values[index].titleName,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: AppFontSize.medium,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
