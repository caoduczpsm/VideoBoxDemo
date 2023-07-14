import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:chewie/chewie.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:video_box_demo/video_box_demo/video_part/video_part_controller.dart';
import '../../models/video_model.dart';

class VideoPart extends StatelessWidget {
  const VideoPart({Key? key, required this.videos}) : super(key: key);

  final List<Video> videos;

  @override
  Widget build(BuildContext context) {

    final VideoPartController videoController = Get.put(VideoPartController());
    videoController.initState(videos);

    return GetBuilder<VideoPartController>(
      init: videoController,
      builder: (controller) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return Chewie(controller: controller.chewieControllers[index]);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
