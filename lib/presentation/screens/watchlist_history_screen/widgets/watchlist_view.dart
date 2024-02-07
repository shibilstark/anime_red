// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/watch_list/watch_list_model/watch_list_model.dart';
import 'package:anime_red/presentation/bloc/watch_list/watch_list_bloc.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/constants/assets.dart';
import '../../../bloc/anime/anime_bloc.dart';
import '../../../router/router.dart';

class WatchlistViewWidget extends StatefulWidget {
  const WatchlistViewWidget({
    super.key,
  });

  @override
  State<WatchlistViewWidget> createState() => _WatchlistViewWidgetState();
}

class _WatchlistViewWidgetState extends State<WatchlistViewWidget> {
  late ValueNotifier<WatchListType?> selectedCollection;

  @override
  void initState() {
    selectedCollection = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    selectedCollection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              WatchListType.values.length,
              (index) => WatchlistCollectionSelectorTileWidget(
                holdingValue: WatchListType.values[index],
                selected: selectedCollection,
              ),
            ),
          ),
          const Gap(H: 10),
          Expanded(
            child: BlocBuilder<WatchListBloc, WatchListState>(
              builder: (context, state) {
                if (state.watchList.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                      AppLottieAssets.emptyBox,
                      backgroundLoading: true,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }

                return ValueListenableBuilder(
                    valueListenable: selectedCollection,
                    builder: (context, value, _) {
                      if (value == null) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 6,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => WatchListTileWidget(
                              model: state.watchList[index]),
                          itemCount: state.watchList.length,
                        );
                      }

                      final collectionedWatchList = state.watchList
                          .where((element) => element.watchListType == value)
                          .toList();

                      if (collectionedWatchList.isEmpty) {
                        return Center(
                          child: Lottie.asset(
                            AppLottieAssets.emptyBox,
                            backgroundLoading: true,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 6,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => WatchListTileWidget(
                            model: collectionedWatchList[index]),
                        itemCount: collectionedWatchList.length,
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

class WatchlistCollectionSelectorTileWidget extends StatelessWidget {
  const WatchlistCollectionSelectorTileWidget({
    super.key,
    required this.holdingValue,
    required this.selected,
  });

  final ValueNotifier<WatchListType?> selected;
  final WatchListType holdingValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selected.value == null || selected.value != holdingValue) {
          selected.value = holdingValue;
        } else {
          selected.value = null;
        }

        selected.notifyListeners();
      },
      child: ValueListenableBuilder(
          valueListenable: selected,
          builder: (context, value, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                color: value == holdingValue ? AppColors.white : AppColors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: value == holdingValue ? 15 : 10,
              ),
              child: Text(
                holdingValue.titleName,
                style: TextStyle(
                  color:
                      value == holdingValue ? AppColors.black : AppColors.white,
                  fontWeight: value == holdingValue
                      ? AppFontWeight.bold
                      : AppFontWeight.normal,
                  fontSize: AppFontSize.small,
                ),
              ),
            );
          }),
    );
  }
}

class WatchListTileWidget extends StatelessWidget {
  const WatchListTileWidget({
    super.key,
    required this.model,
  });

  final WatchListModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AnimeBloc>().add(AnimeGetInfo(model.id));

        AppNavigator.push(
            context: context,
            screenName: AppRouter.ANIME_PLAYER_SCREEN,
            arguments: {"args": (model.id, model.title)});
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: NetWorkImageWidget(
                      image: model.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.white,
                    ),
                    child: Text(
                      model.subOrDub.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.red,
                        fontWeight: AppFontWeight.bold,
                        fontSize: AppFontSize.small,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(H: 5),
          Text(
            model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: AppFontWeight.bold,
              fontSize: AppFontSize.small,
            ),
          ),
          const Gap(H: 5),
          SizedBox(
            child: Row(
              children: [
                WatchlistActionButtonWidget(
                  icon: Icons.favorite_rounded,
                  iconColor: AppColors.red,
                  onTap: () {
                    context
                        .read<WatchListBloc>()
                        .add(WatchListRemoveItem(model.id));
                  },
                ),
                const Gap(W: 2),
                WatchlistActionButtonWidget(
                  icon: Icons.edit_note_rounded,
                  iconColor: AppColors.white,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        contentPadding: AppPadding.normalScreenPadding,
                        content: ScreenPersonlizedWatchlistDialog(
                          animeNama: model.title,
                          onTap: (newWatchlistType) {
                            context.read<WatchListBloc>().add(
                                WatchListUpdateType(
                                    id: model.id, type: newWatchlistType));
                          },
                          currentType: model.watchListType,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ScreenPersonlizedWatchlistDialog extends StatelessWidget {
  const ScreenPersonlizedWatchlistDialog({
    super.key,
    required this.currentType,
    required this.onTap,
    required this.animeNama,
  });

  final void Function(WatchListType type) onTap;
  final WatchListType currentType;
  final String animeNama;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              animeNama,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                color: AppColors.indicator,
                fontWeight: AppFontWeight.bolder,
                fontSize: AppFontSize.large,
              ),
            ),
            const Gap(H: 10),
            const Text(
              "Want to change watch list type?",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: AppFontWeight.normal,
                fontSize: AppFontSize.small,
              ),
            ),
            const Divider(
              color: AppColors.silver,
              thickness: 2,
            ),
            const Gap(H: 5),
            SingleChildScrollView(
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
                                    color: currentType ==
                                            WatchListType.values[index]
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
          ],
        ),
      ),
    );
  }
}

class WatchlistActionButtonWidget extends StatelessWidget {
  const WatchlistActionButtonWidget({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.grey,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
