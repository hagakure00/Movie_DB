import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MyVideoPlayerSerie extends StatefulWidget {
  const MyVideoPlayerSerie({Key? key, required this.serieId}) : super(key: key);

  final String serieId;

  @override
  _MyVideoPlayerSerieState createState() => _MyVideoPlayerSerieState();
}

class _MyVideoPlayerSerieState extends State<MyVideoPlayerSerie> {

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: widget.serieId,
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
