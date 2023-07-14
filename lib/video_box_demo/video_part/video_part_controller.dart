
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../models/video_model.dart';

class VideoPartController extends GetxController {

  var index = 0.obs;
  late PageController pageController;
  late List<VideoPlayerController> _controllers;
  late List<ChewieController> chewieControllers;

  void initState(List<Video> videos) {
    _controllers = videos.map((video) => VideoPlayerController.networkUrl(Uri.parse(video.url!))).toList();
    chewieControllers = _controllers.map((controller) => ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
    )).toList();

    pageController = PageController();
    pageController.addListener(() {
      index.value = pageController.page!.round();
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var controller in chewieControllers) {
      controller.dispose();
    }
  }
}
