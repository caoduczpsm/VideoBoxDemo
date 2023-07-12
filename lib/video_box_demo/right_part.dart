import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';
// ignore: depend_on_referenced_packages
import 'package:visibility_detector/visibility_detector.dart';

import '../models/message_model.dart';

class RightPart extends StatefulWidget {
  final Message? selectedMessage;

  const RightPart({Key? key, required this.selectedMessage}) : super(key: key);

  @override
  State<RightPart> createState() => _RightPartState();
}

class _RightPartState extends State<RightPart> {
  late final TextStyle textStyle;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    textStyle = const TextStyle(fontSize: 18);
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildNewFeed() {
    return Container(
      key: ValueKey<Message?>(widget.selectedMessage),
      child: widget.selectedMessage == null
          ? Text(
              'No item selected',
              style: textStyle,
            )
          : Text(
              widget.selectedMessage!.message!,
              style: textStyle,
            ),
    );
  }

  Widget _buildVideoPlayer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VisibilityDetector(
                  key: const Key("video-player"),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction == 0) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(scale: animation, child: child),
        child: widget.selectedMessage?.message == "#playVideo#"
            ? _buildVideoPlayer()
            : _buildNewFeed(),
      ),
    );
  }
}
