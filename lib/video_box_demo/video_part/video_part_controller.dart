
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';
// ignore: depend_on_referenced_packages
import 'package:chewie/chewie.dart';
import '../../models/video_model.dart';

class VideoPartController extends GetxController {

  var index = 0.obs;
  var isLastVideo = false.obs;
  late VideoPlayerController _controller;
  late ChewieController chewieController;

  void initState(List<Video> videos) {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[index.value].url!));

    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: isLastVideo.value,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
    );

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        index.value++;
        if (index.value == videos.length) {
          index.value = 0;
          isLastVideo.value = true;
        } else {
          isLastVideo.value = false;
        }

        _controller.dispose();
        chewieController.dispose();
        _controller = VideoPlayerController.networkUrl(
            Uri.parse(videos[index.value].url!));
        chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: isLastVideo.value,
          aspectRatio: 16 / 9,
          allowFullScreen: true,
          allowPlaybackSpeedChanging: true,
          autoInitialize: true,
        );
        update();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    chewieController.dispose();
  }
}