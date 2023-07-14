// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import '../../api/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/news_model.dart';
import '../../models/video_model.dart';
import '../../mqtt/mqtt_manager.dart';
import '../../mqtt/state/mqtt_app_state.dart';
import '../../ults/constants.dart';


class VideoController extends GetxController {
  RxList<News> news = <News>[].obs;
  RxList<Video> videos = <Video>[].obs;
  Message? message;
  RxBool isShowingNewsFeed = true.obs;

  final MQTTManager mqttManager = MQTTManager(
    host: Constants.host,
    identifier: Constants.deviceId,
    state: Get.find<MQTTAppState>(),
  );

  RxInt currentIndex = 0.obs; // Change to RxInt type

  void fetchNews() async {
    while (true) {
      List<News> newMessages = await APIManager().getMessages();
      news.assignAll(newMessages);
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

  void setMessage(Message newMessage) {
    message = newMessage;
    isShowingNewsFeed.value = false;
    resetMessage();

    update();
  }

  void resetMessage() {
    Future.delayed(Duration(seconds: int.parse(message!.payload!.ThoiLuong!)),
            () {
          isShowingNewsFeed.value = true;
          update();
        });
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    fetchVideos();
    Get.put(MQTTAppState());
    mqttManager.initializeMQTTClient();
    mqttManager.connect();
  }
}