// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_box_demo/ults/constants.dart';
import 'package:video_box_demo/video_box_demo/news_feed/news_feed_controller.dart';
import '../../models/news_model.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class NewsFeedPart extends StatelessWidget {
  NewsFeedPart({Key? key, required this.news}) : super(key: key);

  final List<News> news;

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

  final newsFeedController = Get.put(NewsFeedController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: newsFeedController,
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 19,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, -1.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: RotationTransition(
                            turns: Tween<double>(
                              begin: -0.125,
                              end: 0.0,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                          key: ValueKey<int>(controller.currentIndex.value),
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          child: CachedNetworkImage(
                                            imageUrl: news[controller
                                                .currentIndex.value]
                                                .imageUrl!,
                                            placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                            const Icon(Icons.error),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        news[controller.currentIndex.value]
                                            .message!,
                                        style: textTitleStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.justify,
                                      ),
                                      Text(
                                        news[controller.currentIndex.value]
                                            .description!,
                                        style: textDescriptionStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.previousPage();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          '${controller.currentIndex.value + 1}',
                          style: currentPageTextStyle,
                        ),
                        Text(
                          ' / ${news.length}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.nextPage();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        });
  }
}
