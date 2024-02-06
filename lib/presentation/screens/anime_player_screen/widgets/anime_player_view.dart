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

    chewieController = ChewieController(
      videoPlayerController: videoPlayercontroller,
      autoPlay: true,
      aspectRatio: 16 / 9,
      showOptions: false,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
      showControls: false,
      customControls: const Row(
        children: [
          Icon(Icons.play_arrow),
        ],
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayercontroller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeSuccess) {
          if (state.playerData != null) {
            state.playerData!.fold((l) => null, (r) {
              videoId = r.currentLink.url;
              videoPlayercontroller = VideoPlayerController.networkUrl(
                Uri.parse(videoId),
              );
              chewieController = ChewieController(
                videoPlayerController: videoPlayercontroller,
                autoPlay: true,
                aspectRatio: 16 / 9,
                showOptions: false,
                allowPlaybackSpeedChanging: true,
                autoInitialize: true,
              );
            });
          }
        }

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(
            controller: chewieController,
          ),
        );
      },
    );
  }
}
