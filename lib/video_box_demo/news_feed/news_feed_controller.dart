import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import '../../models/news_model.dart';
import '../main/video_box_controller.dart';

class NewsFeedController extends GetxController {
  var currentIndex = (0).obs;
  Timer? timer;
  RxList<News> news = <News>[].obs;

  final videoController = Get.find<VideoController>();

  NewsFeedController() {
    news = videoController.news;
  }

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updateIndex();
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  void updateIndex() {
    currentIndex.value = currentIndex.value < news.length - 1
        ? currentIndex.value + 1
        : 0;
    update();
  }

  void previousPage() {
    timer?.cancel();
    currentIndex.value =
    currentIndex.value > 0 ? currentIndex.value - 1 : news.length - 1;
    update();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updateIndex();
    });
  }

  void nextPage() {
    timer?.cancel();
    currentIndex.value =
    currentIndex.value < news.length - 1 ? currentIndex.value + 1 : 0;
    update();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updateIndex();
    });
  }
}

