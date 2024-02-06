import 'package:anime_red/config/config.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../bloc/anime/anime_bloc.dart';

class AnimePlayerView extends StatefulWidget {
  const AnimePlayerView({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  State<AnimePlayerView> createState() => _AnimePlayerViewState();
}

class _AnimePlayerViewState extends State<AnimePlayerView> {
  late String videoId;

  late ChewieController chewieController;
  late VideoPlayerController videoPlayercontroller;
  @override
  void initState() {
    videoId = widget.videoId;
    videoPlayercontroller = VideoPlayerController.networkUrl(
      Uri.parse(videoId),
    );

    chewieController = _getCustomContrller(videoPlayercontroller);

    super.initState();
  }

  ChewieController _getCustomContrller(
      VideoPlayerController videoPlayerController) {
    return ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        autoInitialize: true,
        allowFullScreen: true,
        aspectRatio: 16 / 9,
        showControlsOnInitialize: false,
        showControls: true,
        allowedScreenSleep: false,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: AppColors.grey,
          bufferedColor: AppColors.silver,
          playedColor: AppColors.white,
          handleColor: AppColors.red,
        ));
  }

  @override
  void dispose() {
    chewieController.pause();
    videoPlayercontroller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimeBloc, AnimeState>(
        listener: (context, state) {
          if (state is AnimeSuccess) {
            if (state.playerData != null) {
              chewieController.pause();

              state.playerData!.fold((l) => null, (r) {
                videoId = r.currentLink.url;
                videoPlayercontroller = VideoPlayerController.networkUrl(
                  Uri.parse(videoId),
                );
                chewieController = _getCustomContrller(videoPlayercontroller);
              });

              chewieController.play();
            }
          }
        },
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: chewieController,
          ),
        ));
  }
}
