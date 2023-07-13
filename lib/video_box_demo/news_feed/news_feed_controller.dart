import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import '../../models/message_model.dart';

class NewsFeedController extends GetxController {

  var currentIndex = (0).obs;

  void updateIndex(List<Message> messages) {
      currentIndex.value =
      currentIndex.value < messages.length - 1 ? currentIndex.value + 1 : 0;
    Timer(const Duration(seconds: 10), () => updateIndex(messages));
  }

  void previousPage(List<Message> messages) {
      currentIndex.value =
      currentIndex.value > 0 ? currentIndex.value - 1 : messages.length - 1;
      update();
  }

  void nextPage(List<Message> messages) {
      currentIndex.value =
      currentIndex.value < messages.length - 1 ? currentIndex.value + 1 : 0;
      update();
  }

}


