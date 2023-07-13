import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:chewie/chewie.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:video_box_demo/video_box_demo/video_part/video_part_controller.dart';
import '../../models/video_model.dart';
import '../../ults/constants.dart';

class VideoPart extends StatelessWidget {
  const VideoPart({Key? key, required this.videos}) : super(key: key);

  final List<Video> videos;

  final textTitleStyle = const TextStyle(
      fontSize: Constants.textTitleSize,
      fontWeight: FontWeight.bold,
      fontFamily: Constants.fontName);
  final textDescriptionStyle = const TextStyle(
      fontSize: Constants.textBodySize, fontFamily: Constants.fontName);
  final currentPageTextStyle = const TextStyle(
      fontSize: Constants.textBodySize,
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontFamily: Constants.fontName);

  @override
  Widget build(BuildContext context) {
    // Use Get.put() to create and get the instance of VideoController
    final VideoPartController videoController = Get.put(VideoPartController());

    // Call initState() to initialize the controllers
    videoController.initState(videos);

    return GetBuilder<VideoPartController>(
      // Pass the controller to the init parameter
      init: videoController,
      // Return a widget in the builder parameter
      builder: (controller) {
        return Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: AspectRatio(
              key: ValueKey<int>(controller.index.value),
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Chewie(controller: controller.chewieController),
              ),
            ),
          ),
        );
      },
    );
  }
}
