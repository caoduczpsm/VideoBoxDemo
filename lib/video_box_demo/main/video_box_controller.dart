// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import '../../api/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/video_model.dart';

class VideoController extends GetxController {

  RxList<Message> messages = <Message>[].obs;
  RxList<Video> videos = <Video>[].obs;

  void fetchMessage() async {
    while (true) {
      List<Message> newMessages = await APIManager().getMessages();
      messages.assignAll(newMessages);
      update();
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  void fetchVideos() async {
    while (true) {
      List<Video> newVideos = await APIManager().getVideos();
      videos.assignAll(newVideos);
      update();
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMessage();
    fetchVideos();
  }
}