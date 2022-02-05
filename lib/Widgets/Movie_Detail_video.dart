import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({Key? key, required this.movieId}) : super(key: key);

  final String movieId;

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: widget.movieId,
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
      hideThumbnail: true)
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? const Center(child:  SpinKitFadingCircle(color: primary,size: 20))
        : YoutubePlayer(controller: _controller!,
           progressColors: const ProgressBarColors(handleColor: primary,
           playedColor: primary),
      onEnded: (YoutubeMetaData meta) {
          _controller!.play();
          _controller!.pause();
      },
    );
  }
}
