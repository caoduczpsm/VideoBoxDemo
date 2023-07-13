import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:chewie/chewie.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';
import '../models/video_model.dart';

class VideoPart extends StatefulWidget {
  const VideoPart({Key? key, required this.videos}) : super(key: key);

  final List<Video> videos;

  @override
  State<VideoPart> createState() => _VideoPartState();
}

class _VideoPartState extends State<VideoPart> {
  late final TextStyle textStyle;
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  int index = 0;
  bool isLastVideo = false;

  @override
  void initState() {
    super.initState();
    textStyle = const TextStyle(fontSize: 18);

    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videos[index].url!));

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: isLastVideo,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
    );

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          index++;
          if (index == widget.videos.length) {
            index = 0;
            isLastVideo = true;
          } else {
            isLastVideo = false;
          }

          _controller.dispose();
          _chewieController.dispose();
          _controller = VideoPlayerController.networkUrl(
              Uri.parse(widget.videos[index].url!));
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: true,
            looping: isLastVideo,
            aspectRatio: 16 / 9,
            allowFullScreen: true,
            allowPlaybackSpeedChanging: true,
            autoInitialize: true,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  Widget _buildVideoPlayer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: AspectRatio(
            key: ValueKey<int>(index),
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Chewie(controller: _chewieController),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildVideoPlayer(),
    );
  }
}
