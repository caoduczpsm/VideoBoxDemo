// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:video_box_demo/video_box_demo/main/video_box_controller.dart';
import 'package:video_box_demo/video_box_demo/sos_news/sos_news.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:video_box_demo/video_box_demo/video_part/video_part.dart';
import '../news_feed/news_feed_part.dart';

class VideoBox extends StatelessWidget {
  const VideoBox({Key? key}) : super(key: key);

  static const int fullScreenMode = 0;
  static const int notifyMode = 1;
  static const int leftMode = 2;
  static const int rightMode = 3;

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
          return Obx(() {

            Widget leftPart, rightPart, notifyPart, fullScreen;

            if (!controller.isShowingNewsFeed.value) {
              int displayArea = int.parse(controller.message!.payload!.VungPhat!);

              if (displayArea == fullScreenMode) {
                fullScreen = SosNews(message: controller.message!);
                leftPart = Container();
                rightPart = Container();
              } else if (displayArea == leftMode) {
                leftPart =  SosNews(message: controller.message!);
                rightPart = VideoPart(videos: controller.videos);
                //Tạm
                rightPart = Container();
              } else { // rightMode
                rightPart = SosNews(message: controller.message!);
                leftPart = NewsFeedPart(news: controller.news);
              }
            } else {
              leftPart = NewsFeedPart(news: controller.news);
              rightPart = VideoPart(videos: controller.videos);
              //Tạm
              rightPart = Container();
            }

            fullScreen = Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: leftPart,
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
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    //child: VideoPart(videos: controller.videos,),
                    child: rightPart,
                  ),
                ),
              ],
            );
            return fullScreen;
          });
        },
      ),
    );
  }
}
