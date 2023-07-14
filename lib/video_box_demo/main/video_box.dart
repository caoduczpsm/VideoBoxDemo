// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:video_box_demo/video_box_demo/main/video_box_controller.dart';
import 'package:video_box_demo/video_box_demo/sos_news/sos_news.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import '../news_feed/news_feed_part.dart';

class VideoBox extends StatelessWidget {
  const VideoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Video Box'),
      ),
      body: GetBuilder<VideoController>(
        init: controller,
        builder: (_) {
          if (controller.news.isEmpty || controller.videos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(() {
                        if (controller.isShowingNewsFeed.value) {
                          return NewsFeedPart(news: controller.news);
                        } else {
                          return SosNews(message: controller.message!);
                        }
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 70),
                child: const VerticalDivider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  //child: VideoPart(videos: controller.videos,),
                  child: Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
