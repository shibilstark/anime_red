import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/common_types/enums.dart';
import 'package:anime_red/domain/models/anime_streaminglink_model.dart';
import 'package:anime_red/domain/models/server_model.dart';
import 'package:anime_red/presentation/screens/anime_player_screen/widgets/anime_player_view.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/presentation/widgets/shimmer_widget.dart';
import 'package:anime_red/utils/extensions/extensions.dart';
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
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeSuccess) {
          return widget.isPlayerMode
              ? state.playerData == null
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
                        const Gap(H: 10),
                        const ServerOptionsShimmerWidget(),
                        const Gap(H: 10),
                        const ServerOptionsShimmerWidget(),
                      ],
                    )
                  : state.playerData!.fold(
                      (l) => const Column(
                            children: [
                              Text(
                                "Failed to featch servers please, can't fulfill your request",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: AppFontSize.small,
                                ),
                              ),
                            ],
                          ), (serverOptions) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(H: 10),
                          AnimePlayerView(
                            videoId: serverOptions.currentLink.url,
                          ),
                          const Gap(H: 10),
                          PlayerOptionsWidget(
                            availableServers: serverOptions.servers,
                            type: OptionTileType.quality,
                            onTap: (index, type, holdingValue, server) {
                              context.read<AnimeBloc>().add(
                                    AnimeChangeStreamingQuality(
                                      StreamingQuality.values
                                          .byName(holdingValue),
                                      state.currentPlayingEpisodeId!,
                                    ),
                                  );
                            },
                            title: "Quality",
                            currentServer: serverOptions.currentServer,
                            currentlink: serverOptions.currentLink,
                            values: serverOptions.streamingLinks.sources
                                .map((e) => e.quality.name)
                                .toList(),
                          ),
                          const Gap(H: 15),
                          PlayerOptionsWidget(
                            availableServers: serverOptions.servers,
                            type: OptionTileType.server,
                            onTap: (index, type, holdingValue, server) {
                              context
                                  .read<AnimeBloc>()
                                  .add(AnimeChangeStreamingServer(
                                    episodeId: state.currentPlayingEpisodeId!,
                                    server: server,
                                  ));
                            },
                            title: "Servers",
                            currentServer: serverOptions.currentServer,
                            currentlink: serverOptions.currentLink,
                            values: serverOptions.servers
                                .map((e) => e.url)
                                .toList(),
                          ),
                        ],
                      );
                    })
              : const SizedBox();
        }

        return const SizedBox();
      },
    );
  }
}

class ServerOptionsShimmerWidget extends StatelessWidget {
  const ServerOptionsShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppPadding.normalScreenPadding.left),
      child: Row(
        children: [
          ShimmerWidget(
            width: context.screenWidth * 0.1,
            height: 15,
            radius: 3,
          ),
          const Gap(W: 10),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                3,
                (index) => ShimmerWidget(
                  width: context.screenWidth * 0.15,
                  height: 20,
                  radius: 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum OptionTileType { server, quality }

class PlayerOptionsWidget extends StatelessWidget {
  const PlayerOptionsWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.values,
    required this.type,
    required this.currentServer,
    required this.currentlink,
    required this.availableServers,
  });

  final String title;
  final List<String> values;
  final void Function(
      int index, OptionTileType type, String holdingValue, ServerModel) onTap;
  final OptionTileType type;
  final StreamingSourcesModel currentlink;
  final ServerModel currentServer;
  final List<ServerModel> availableServers;

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
                values.length,
                (index) {
                  bool isSelected;

                  if (type == OptionTileType.server) {
                    isSelected = values[index] == currentServer.url;
                  } else {
                    isSelected = values[index] == currentlink.quality.name;
                  }

                  return GestureDetector(
                    onTap: () {
                      if (type == OptionTileType.server) {
                        onTap(
                          index,
                          type,
                          values[index],
                          availableServers.firstWhere(
                              (element) => element.url == values[index]),
                        );
                      } else {
                        onTap(
                          index,
                          type,
                          values[index],
                          currentServer,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: isSelected ? AppColors.white : AppColors.grey,
                          borderRadius: BorderRadius.circular(3)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 10,
                      ),
                      child: Text(
                        type == OptionTileType.server
                            ? "Server ${index + 1}"
                            : StreamingQuality.values
                                .byName(values[index])
                                .toShowableString,
                        style: TextStyle(
                          color: isSelected ? AppColors.black : AppColors.white,
                          fontWeight: AppFontWeight.bold,
                          fontSize: AppFontSize.small,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
