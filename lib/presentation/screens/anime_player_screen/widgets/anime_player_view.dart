// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:anime_red/config/config.dart';
import 'package:anime_red/domain/watch_history/watch_history_repository.dart/watch_history_repository.dart';
import 'package:anime_red/injector/injector.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../bloc/anime/anime_bloc.dart';

class AnimePlayerView extends StatefulWidget {
  const AnimePlayerView({
    super.key,
    required this.videoId,
    required this.animeId,
    required this.eipsodeId,
    required this.lastPostion,
  });

  final String videoId;
  final String animeId;
  final String eipsodeId;
  final Duration? lastPostion;

  @override
  State<AnimePlayerView> createState() => _AnimePlayerViewState();
}

class _AnimePlayerViewState extends State<AnimePlayerView> {
  late String videoId;

  late ChewieController chewieController;
  late VideoPlayerController videoPlayercontroller;
  late StreamController<(Duration, Duration)> streamController;

  late StreamSubscription<dynamic> historyStream;

  @override
  void initState() {
    videoId = widget.videoId;
    streamController = StreamController<(Duration, Duration)>.broadcast();
    historyStream =
        Stream.periodic(const Duration(seconds: 5)).listen((event) async {
      final currentDuration = await videoPlayercontroller.position;
      final totalLength = videoPlayercontroller.value.duration;
      if (currentDuration != null && totalLength != Duration.zero) {
        streamController.add((currentDuration, totalLength));
      }
    });
    videoPlayercontroller = VideoPlayerController.networkUrl(
      Uri.parse(videoId),
    );
    streamController.stream.listen((event) {
      final (currentDuration, totalLength) = event;
      getIt<WatchHistoryRepository>().updateStatus(
        id: widget.animeId,
        newEpisodeId: widget.eipsodeId,
        newPosition: currentDuration,
        newTotalLength: totalLength,
      );
    });

    chewieController = _getCustomContrller(videoPlayercontroller);

    super.initState();
  }

  ChewieController _getCustomContrller(
      VideoPlayerController videoPlayerController) {
    return ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        autoInitialize: true,
        looping: false,
        allowFullScreen: true,
        aspectRatio: 16 / 9,
        showControlsOnInitialize: false,
        showControls: true,
        startAt: widget.lastPostion,
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
    historyStream.cancel();
    streamController.close();
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
